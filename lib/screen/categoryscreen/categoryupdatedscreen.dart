// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchmoney/models/categorypagemodel.dart';
import 'package:merchmoney/screen/categoryscreen/functions.dart';

import 'package:merchmoney/widgets/textfield.dart';

class Categoryupdated extends StatefulWidget {
  const Categoryupdated({
    super.key,
    required this.categoryOfIndex,
    this.loadcategories,
  });
  final Categorypage categoryOfIndex;
  final dynamic loadcategories;
  @override
  State<Categoryupdated> createState() => _CategoryupdatedState();
}

class _CategoryupdatedState extends State<Categoryupdated> {
  File? updatedImage;
  String? updatedImagePath;
  String? initialImage;

  TextEditingController categoryupdatecontroller = TextEditingController();
  @override
  void initState() {
    categoryupdatecontroller.text = widget.categoryOfIndex.categoryname;
    initialImage = widget.categoryOfIndex.imagepath;

    super.initState();
  }

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
                    showcategoryupdateimage(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF030655),
                    radius: 80,
                    backgroundImage: updatedImagePath != null
                        ? FileImage(File(updatedImagePath ?? ''))
                        : FileImage(File(initialImage!)),
                    child: updatedImagePath == null
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
                  controller: categoryupdatecontroller,
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
                      buttontext: "Update",
                      backgroundcolor: const Color(0xFF030655),
                      onpressed: () {
                        if (updatedImagePath != null || initialImage != null) {
                          if (categoryupdatecontroller.text.isNotEmpty) {
                            final updatedCategory = Categorypage(
                              imagepath: updatedImagePath == null
                                  ? initialImage!
                                  : updatedImagePath!,
                              categorykey: widget.categoryOfIndex.categorykey,
                              categoryname: categoryupdatecontroller.text,
                              isassetimage: false,
                            );
                            updatecategory(
                                widget.categoryOfIndex.categorykey ?? '',
                                updatedCategory);

                            Navigator.of(context).pop(true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.white,
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  "Please enter a category name ",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: const Color(0xFF030655)),
                                )));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.white,
                              duration: const Duration(seconds: 2),
                              content: Text(
                                "Please select an Image",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: const Color(0xFF030655)),
                              )));
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showcategoryupdateimage(BuildContext context) {
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

  Future<void> pickimageFromgallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) {
      return;
    }
    setState(() {
      updatedImage = File(returnImage.path);
      updatedImagePath = returnImage.path;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Move pop outside of the function call
  }

  Future<void> capturecategoryimage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) {
      return;
    }
    setState(() {
      updatedImage = File(returnImage.path);
      updatedImagePath = returnImage.path;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Move pop outside of the function call
  }
}
