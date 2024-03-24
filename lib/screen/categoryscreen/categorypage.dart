import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:merchmoney/models/categorypagemodel.dart'; // Import your Categorypage model
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/categoryscreen/categoryadded.dart';
import 'package:merchmoney/screen/categoryscreen/categoryupdatedscreen.dart';
import 'package:merchmoney/screen/categoryscreen/functions.dart';
import 'package:merchmoney/screen/destinationfolder/destinationpage.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Categorypage> categories = [];
  List<Categorypage> predefinedcategories = [];
  TextEditingController searchcontroller = TextEditingController();
  List<Itempage> searchedProducts = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  loadCategories() async {
    predefinedcategories = [
      Categorypage(
          categorykey: "1",
          isassetimage: true,
          imagepath: "assets/images/fruits.jpg",
          categoryname: "Fruits"),
      Categorypage(
          categorykey: "2",
          isassetimage: true,
          imagepath: "assets/images/vegetables 2.jpg",
          categoryname: "Vegetables"),
      Categorypage(
          categorykey: "3",
          isassetimage: true,
          imagepath: "assets/images/groccery 1.jpg",
          categoryname: "Groccery Items"),
      Categorypage(
          categorykey: "4",
          isassetimage: true,
          imagepath: "assets/images/stationar products 1.jpg",
          categoryname: "Stationary Items"),
      Categorypage(
          categorykey: "5",
          isassetimage: true,
          imagepath: "assets/images/fish meat.jpg",
          categoryname: "Fish"),
      Categorypage(
          categorykey: "6",
          isassetimage: true,
          imagepath: "assets/images/meat 1.jpg",
          categoryname: "Meat"),
      Categorypage(
          categorykey: "7",
          isassetimage: true,
          imagepath: "assets/images/beverages 1.jpg",
          categoryname: "Beverages"),
      Categorypage(
          categorykey: "8",
          isassetimage: true,
          imagepath: "assets/images/cosmetics 1.jpg",
          categoryname: "Cosmetics")
    ];
    final userdefinedcategorie = await getcategories();

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
                    height: height * 0.19,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Category",
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            width: width * 0.92,
                          )
                        ],
                      ),
                    )),
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
                      crossAxisSpacing: 25),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final categoryOfIndex = categories[index];

                    // final imagepath = category.imagepath;
                    if (categoryOfIndex.isassetimage == false) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Destinationpage(
                                categoryOfIndex: categoryOfIndex),
                          ));
                        },
                        onLongPress: () {
                          showmodel(context, categoryOfIndex, loadCategories);
                        },
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Destinationpage(
                                categoryOfIndex: categoryOfIndex),
                          ));
                        },
                        onLongPress: () {},
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

  void showmodel(BuildContext context, Categorypage categoryOfIndex,
      dynamic loadcategories) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: Row(children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => Categoryupdated(
                                      categoryOfIndex: categoryOfIndex,
                                      loadcategories: loadCategories(),
                                    )))
                            .then((value) {
                          if (value == true) {
                            loadCategories();
                          }
                        });
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Color(0xFF030655),
                            size: 40,
                          ),
                          Text("EDIT")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        showdialouge(
                          context,
                          categoryOfIndex.categorykey ?? '',
                        );
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Color(0xFF030655),
                            size: 40,
                          ),
                          Text("Delete")
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }

  void showdialouge(
    BuildContext context,
    String categorykey,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you Sure Want to delete the Category?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    await deletcategory(categorykey);
                    loadCategories();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }
}
