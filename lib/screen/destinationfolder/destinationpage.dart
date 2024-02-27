import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchmoney/models/categorypagemodel.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/destinationfolder/functions.dart';
import 'package:merchmoney/screen/destinationfolder/stockaddedpage.dart';
import 'package:merchmoney/screen/editscreen/editscreen.dart';
import 'package:merchmoney/screen/itemdetails/item_details.dart';
import 'package:merchmoney/widgets/textfield.dart';

class Destinationpage extends StatefulWidget {
  const Destinationpage({super.key, this.categoryOfIndex});
  final Categorypage? categoryOfIndex;

  @override
  State<Destinationpage> createState() => _DestinationpageState();
}

class _DestinationpageState extends State<Destinationpage> {
  List<Itempage> itemlist = [];

  @override
  void initState() {
    initalizeitemlist();
    super.initState();
  }

  Future<void> initalizeitemlist() async {
    final list = await getitem();
    final filteredItems = list
        .where(
            (item) => item.categorykey == widget.categoryOfIndex?.categorykey)
        .toList();
    setState(() {
      // Clear the existing list and add the filtered items to it
      itemlist.clear();
      itemlist.addAll(filteredItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.white,
                  height: height * 0.16,
                  width: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 20),
                    child: Text(
                      widget.categoryOfIndex?.categoryname ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 29,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                        color: Color(0xFF030655)),
                    height: height,
                    width: width,
                    child: itemlist.isEmpty
                        ? Center(
                            child: Text(
                              "Nothing Here",
                              style: GoogleFonts.aboreto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              final item = itemlist[index];
                              return Padding(
                                padding: const EdgeInsetsDirectional.all(10),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ItemDetails(item: item),
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: FileImage(File(
                                                          item.imagepath!)),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name:${item.productname.toString()}',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                'Current rate :${item.currentrate.toString()}',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                'Total Stock : ${item.totalstock.toString()}',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateItemScreen(
                                                        item: item,
                                                        getItems:
                                                            initalizeitemlist(),
                                                      ),
                                                    ))
                                                        .then((value) {
                                                      if (value == true) {
                                                        print('object');
                                                        setState(() {
                                                          initalizeitemlist();
                                                        });
                                                      }
                                                    });
                                                  }),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                  print(
                                                      'key when deleting ${item.itemkey}');
                                                  showDeleteConfirmationDialog(
                                                      context,
                                                      item,
                                                      item.itemkey ?? '');
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: itemlist.length,
                          )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => Stockaddedpage(
                categoryOfIndex: widget.categoryOfIndex,
                getItems: initalizeitemlist()),
          ))
              .then((value) {
            if (value == true) {
              print('object');
              setState(() {
                initalizeitemlist();
              });
            }
          });
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 35,
          color: Color(0xFF030655),
        ),
      ),
    );
  }

// Function to show delete confirmation dialog
  void showDeleteConfirmationDialog(
      BuildContext context, Itempage item, String key) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              print('key for deleting is $key');
              await deleteitem(key);
              initalizeitemlist();
              Navigator.of(context).pop();
              // Close the dialog
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
