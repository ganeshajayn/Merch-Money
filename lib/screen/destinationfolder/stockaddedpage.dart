import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchmoney/models/categorypagemodel.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/destinationfolder/functions.dart';
import 'package:merchmoney/widgets/textfield.dart';

class Stockaddedpage extends StatefulWidget {
  const Stockaddedpage(
      {super.key, this.categoryOfIndex, required this.getItems});
  final Categorypage? categoryOfIndex;
  final dynamic getItems;
  @override
  State<Stockaddedpage> createState() => _StockaddedpageState();
}

class _StockaddedpageState extends State<Stockaddedpage> {
  TextEditingController itemnamecontroller = TextEditingController();
  TextEditingController itemratecontroller = TextEditingController();
  TextEditingController totalstockcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? itemimage;
  String? pickitemimage = "";

  @override
  void initState() {
    print('Stock add page');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFF030655),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xFF030655),
          title: const Text("Add Product"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    showitemimage(context);
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white60,
                    child: itemimage == null // Check if itemimage is null
                        ? const Icon(
                            Icons.add_a_photo_outlined,
                            color: Color(0xFF030655),
                            size: 40,
                          )
                        : ClipOval(
                            child: Image.file(
                              itemimage!,
                              fit: BoxFit.cover,
                              width: 160,
                              height: 160,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        TextFormFieldWidget(
                          controller: itemnamecontroller,
                          prefixIcon: const Icon(Icons.add_box_outlined),
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          labeltext: "Enter the Product Name",
                          hintText: "Product name",
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormFieldWidget(
                          controller: totalstockcontroller,
                          prefixIcon:
                              const Icon(Icons.production_quantity_limits),
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          labeltext: "Enter the Quantity",
                          hintText: "Quantity",
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormFieldWidget(
                          controller: itemratecontroller,
                          prefixIcon: const Icon(Icons.currency_rupee),
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          labeltext: "Enter the Current Rate",
                          hintText: "Rate",
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          width: width * 0.9,
                          height: height * 0.06,
                          child: ElevatedButtonnWidget(
                            backgroundcolor: Colors.white,
                            onpressed: () async {
                              if (formKey.currentState!.validate() &&
                                  pickitemimage != '') {
                                String key = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                final item = Itempage(
                                    imagepath: pickitemimage,
                                    productname: itemnamecontroller.text,
                                    totalstock: totalstockcontroller.text,
                                    currentrate: itemratecontroller.text,
                                    categorykey:
                                        widget.categoryOfIndex!.categorykey,
                                    itemkey: key);

                                additem(item, key);
                                widget.getItems;
                                Navigator.of(context).pop(true);
                              }
                            },
                            buttontext: "Submit",
                            fontsize: 20,
                            textcolor: const Color(0xFF030655),
                            customshape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void showitemimage(BuildContext context) {
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
                        await pickitemimagefromgallery();
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
                        await captureitemimagefromgallery();
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

  Future pickitemimagefromgallery() async {
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnimage == null) {
      return;
    }
    setState(() {
      itemimage = File(returnimage.path);
      pickitemimage = returnimage.path;
    });
    Navigator.of(context).pop();
  }

  Future captureitemimagefromgallery() async {
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnimage == null) {
      return;
    }
    setState(() {
      itemimage = File(returnimage.path);
      pickitemimage = returnimage.path;
    });
    Navigator.of(context).pop();
  }
}
