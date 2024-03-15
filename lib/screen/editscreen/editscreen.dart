import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/destinationfolder/functions.dart';
import 'package:merchmoney/widgets/textfield.dart';

class UpdateItemScreen extends StatefulWidget {
  const UpdateItemScreen({
    super.key,
    required this.item,
    required this.getItems,
    required this.isbranded,
  });
  final Itempage item;
  final dynamic getItems;
  final bool isbranded;
  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  TextEditingController itemnameeditingcontroller = TextEditingController();
  TextEditingController totalstockeditingcontroller = TextEditingController();
  TextEditingController totaleditingratecontroller = TextEditingController();
  TextEditingController mrpratecontroller = TextEditingController();
  TextEditingController brandnamecontroller = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? itemimage;
  String? pickitemimage = "";
  String? dropdownvalue;

  @override
  void initState() {
    super.initState();
    pickitemimage = widget.item.imagepath;
    itemnameeditingcontroller.text = widget.item.productname ?? '';
    totalstockeditingcontroller.text = widget.item.totalstock ?? '';
    totaleditingratecontroller.text = widget.item.currentrate ?? '';
    mrpratecontroller.text = widget.item.mrprate ?? '';
    dropdownvalue = widget.item.dropdown;
    pickitemimage = widget.item.imagepath;
    brandnamecontroller.text = widget.item.brandname ?? '';
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
          title: const Text("Edit Product"),
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
                    child: ClipOval(
                      child: Image.file(
                        File(pickitemimage ?? ''),
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
                          controller: itemnameeditingcontroller,
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
                          controller: totalstockeditingcontroller,
                          prefixIcon:
                              const Icon(Icons.production_quantity_limits),
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          labeltext: "Enter the Quantity",
                          hintText: "Quantity",
                        ),
                        if (widget.isbranded)
                          TextFormFieldWidget(
                            controller: brandnamecontroller,
                            prefixIcon: const Icon(Icons.branding_watermark),
                            fillColor: Colors.white,
                            fillcolourvalue: true,
                            labeltext: "Enter the Brand Name",
                            hintText: "Brand Name",
                          ),
                        TextFormFieldWidget(
                          controller: mrpratecontroller,
                          fillColor: Colors.white,
                          fillcolourvalue: true,
                          labeltext: "Enter the actual rate",
                          prefixIcon: const Icon(Icons.currency_rupee),
                          hintText: "Mrprate",
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormFieldWidget(
                          controller: totaleditingratecontroller,
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
                                final item = Itempage(
                                    mrprate: mrpratecontroller.text,
                                    imagepath: pickitemimage,
                                    productname: itemnameeditingcontroller.text,
                                    totalstock:
                                        totalstockeditingcontroller.text,
                                    currentrate:
                                        totaleditingratecontroller.text,
                                    categorykey: widget.item.categorykey,
                                    itemkey: widget.item.itemkey,
                                    brandname: brandnamecontroller.text,
                                    dropdown: dropdownvalue);
                                print(widget.item.itemkey);
                                updateitem(widget.item.itemkey ?? '', item);
                                print('item is saved $item');
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
