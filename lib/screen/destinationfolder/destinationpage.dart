import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/models/cartmodel.dart';

import 'package:merchmoney/models/categorypagemodel.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/cartpage/functions.dart';
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
                                              height: 90,
                                              width: 90,
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
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name:${item.productname.toString()}',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                item.brandname != null &&
                                                        item.brandname!
                                                            .isNotEmpty
                                                    ? 'Brand:${item.brandname.toString()}'
                                                    : 'Brand : N/A',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                'Current rate :${item.currentrate.toString()}₹ ',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                'Total Stock : ${item.totalstock.toString()}${item.dropdown}',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                'Available Stock : ${item.availablestock ?? item.totalstock}${item.dropdown}',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              InkWell(
                                                child: SizedBox(
                                                    height: height * 0.05,
                                                    child:
                                                        const Icon(Icons.add)),
                                                onTap: () {
                                                  print(
                                                      'Total stock: ${item.totalstock}');
                                                  showitemdialogue(
                                                      context: context,
                                                      itemKey:
                                                          item.itemkey ?? '',
                                                      productName:
                                                          item.productname ??
                                                              '',
                                                      imagepath:
                                                          item.imagepath ?? '',
                                                      categoryname: widget
                                                              .categoryOfIndex
                                                              ?.categoryname ??
                                                          '',
                                                      availablestock:
                                                          item.availablestock ??
                                                              '',
                                                      totalstock:
                                                          item.totalstock ?? '',
                                                      currentrate:
                                                          item.currentrate ??
                                                              '',
                                                      item: item,
                                                      index: index);
                                                },
                                              )
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
                                                        isbranded: item
                                                            .brandname!
                                                            .isNotEmpty,
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
                // isbranded: wid,
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

  void showitemdialogue(
      {required BuildContext context,
      required String itemKey,
      required String productName,
      required String imagepath,
      required String categoryname,
      required String availablestock,
      required String totalstock,
      required String currentrate,
      required Itempage item,
      required int index}) {
    print(totalstock);
    print(availablestock);
    int currentAvailableStock =
        int.tryParse(availablestock) ?? int.parse(totalstock);
    TextEditingController quantitycontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Add Item to Cart"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter the Quantity for $productName'),
              TextFormFieldWidget(
                controller: quantitycontroller,
                keyboardType: TextInputType.number,
                hintText: "Quantity",
              )
            ],
          ),
          actions: [
            TextButtonWidget(
                onpressed: () {
                  Navigator.of(context).pop();
                },
                textbutton: "Cancel"),
            TextButtonWidget(
              onpressed: () async {
                print(currentAvailableStock);
                int quantity = int.tryParse(quantitycontroller.text) ?? 0;

                if (quantity > 0 && quantity <= currentAvailableStock) {
                  int updatedAvailableStock = currentAvailableStock - quantity;
                  // Ensure that available stock doesn't become negative
                  updatedAvailableStock =
                      updatedAvailableStock >= 0 ? updatedAvailableStock : 0;
                  setState(() {
                    item.availablestock = updatedAvailableStock.toString();
                  });
                  print('Item available stock: ${item.availablestock}');
                  // Hive.box<Itempage>('itembox').putAt(index, item);

                  // setState(() {
                  //   initalizeitemlist();
                  // });

                  String cartKey =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Cartmodel newcart = Cartmodel(
                    totalstock: totalstock,
                    imagepath: imagepath,
                    quantity: quantity,
                    cartkey: cartKey,
                    itemkey: itemKey,
                    productname: productName,
                    categorykey: categoryname,
                    currentrate: currentrate,
                    item: item,
                  );

                  addcart(cartKey, newcart);
                  print('Item added to cart');
                  getcart();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text("Added to Cart")),
                  );

                  Navigator.pop(context); // Pop the current screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('Invalid Quantity')),
                  );
                }
              },
              textbutton: "Add to Cart",
            )
          ]),
    );
  }
}
