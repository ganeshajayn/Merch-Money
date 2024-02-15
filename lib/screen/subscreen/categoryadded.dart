// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchmoney/models/categorypagemodel.dart';
import 'package:merchmoney/service/functions.dart';
import 'package:merchmoney/widgets/textfield.dart';

class Categoryadded extends StatefulWidget {
  const Categoryadded({super.key, required this.loadCategories});
  final dynamic loadCategories;
  @override
  State<Categoryadded> createState() => _CategoryaddedState();
}

class _CategoryaddedState extends State<Categoryadded> {
  File? selectImage;
  String? images;

  TextEditingController categorycontroller = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF030655),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF030655),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Your Own Category",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.black, spreadRadius: 6, blurRadius: 5),
              ],
              borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: height * 0.5,
            width: width * 0.8,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showcategoryimage(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF030655),
                    radius: 80,
                    backgroundImage:
                        images != null ? FileImage(File(images ?? '')) : null,
                    child: images == null
                        ? const Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormFieldWidget(
                  controller: categorycontroller,
                  prefixIcon: const Icon(Icons.list),
                  hintText: "Add your category ",
                  labeltext: "CATEGORY NAME",
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: height * 0.05,
                  width: width * 0.75,
                  child: ElevatedButtonnWidget(
                    onpressed: () {
                      // String image = images ?? '';
                      // String categoryname = categorycontroller.text;

                      addcategory(Categorypage(
                          isassetimage: false,
                          imagepath: images!,
                          categoryname: categorycontroller.text));

                      Navigator.of(context).pop(true);
                      widget.loadCategories;
                    },
                    buttontext: "Save",
                    backgroundcolor: const Color(0xFF030655),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showcategoryimage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 130,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                child: Row(children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        pickimageFromgallery();
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.image,
                            color: Color(0xFF030655),
                            size: 40,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        capturecategoryimage();
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Color(0xFF030655),
                            size: 40,
                          ),
                          Text("Camera")
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

  Future pickimageFromgallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return;
    }
    setState(() {
      selectImage = File(returnImage.path);
      images = returnImage.path;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future capturecategoryimage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) {
      return;
    }
    setState(() {
      selectImage = File(returnImage.path);
      images = returnImage.path;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
