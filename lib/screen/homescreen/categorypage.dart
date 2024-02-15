import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/models/categorypagemodel.dart'; // Import your Categorypage model
import 'package:merchmoney/screen/subscreen/categoryadded.dart';
import 'package:merchmoney/service/functions.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Categorypage> categories = [];
  List<Categorypage> predefinedcategories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  loadCategories() async {
    predefinedcategories = [
      Categorypage(
          isassetimage: true,
          imagepath: "assets/images/fruits.jpg",
          categoryname: "Fruits"),
      Categorypage(
          isassetimage: true,
          imagepath: "assets/images/vegetables 2.jpg",
          categoryname: "Vegetables"),
      Categorypage(
          isassetimage: true,
          imagepath: "assets/images/groccery 1.jpg",
          categoryname: "Groccery Items"),
      Categorypage(
          isassetimage: true,
          imagepath: "assets/images/stationar products 1.jpg",
          categoryname: "Stationary Items"),
      Categorypage(
          isassetimage: true,
          imagepath: "assets/images/fish meat.jpg",
          categoryname: "Fish"),
      Categorypage(
          isassetimage: true,
          imagepath: "assets/images/meat 1.jpg",
          categoryname: "Meat"),
      Categorypage(
          isassetimage: true,
          imagepath: "assets/images/beverages 1.jpg",
          categoryname: "Beverages"),
      Categorypage(
          isassetimage: true,
          imagepath: "assets/images/cosmetics 1.jpg",
          categoryname: "Cosmetics")
    ];
    final userdefinedcategorie = await getcategories();
    print(' the length of database is ${userdefinedcategorie.length}');
    setState(() {
      categories = [...predefinedcategories, ...userdefinedcategorie];
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white38,
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: height * 0.16,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: Text(
                      "Category",
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Color(0xFF030655),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    print('the length ${categories.length}');
                    final categoryOfIndex = categories[index];
                    print(' the path of image is ${categoryOfIndex.imagepath}');
                    // final imagepath = category.imagepath;
                    if (categoryOfIndex.isassetimage == false) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    FileImage(File(categoryOfIndex.imagepath)),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 4,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                color: Colors.black.withOpacity(0.5),
                                child: Text(
                                  categoryOfIndex.categoryname,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(categoryOfIndex.imagepath),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 4,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                color: Colors.black.withOpacity(0.5),
                                child: Text(
                                  categoryOfIndex.categoryname,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => Categoryadded(
              loadCategories: loadCategories(),
            ),
          ))
              .then((value) {
            if (value == true) {
              loadCategories();
            }
          });
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color(0xFF030655), size: 40),
      ),
    );
  }
}
