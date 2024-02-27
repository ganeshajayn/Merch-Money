import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/models/itemmodel.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.item});
  final Itempage item;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF030655),
        elevation: 0,
        centerTitle: true,
        title: Text(""),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(1, 1)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                ItemImageContainerWidget(
                    item: widget.item, height: 250, width: 250),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.productname!.toUpperCase(),
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Rate: ${widget.item.currentrate}',
                          style: GoogleFonts.openSans(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Quantity: ${widget.item.totalstock}',
                          style: GoogleFonts.openSans(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemImageContainerWidget extends StatelessWidget {
  const ItemImageContainerWidget({
    super.key,
    required this.item,
    required this.height,
    required this.width,
  });
  final Itempage item;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: FileImage(File(item.imagepath!)), fit: BoxFit.cover),
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 130, 128, 128).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}
