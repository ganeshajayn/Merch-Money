import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:merchmoney/models/cartmodel.dart';
import 'package:merchmoney/models/itemmodel.dart';

import 'package:merchmoney/screen/biladd/billadd.dart';

import 'package:merchmoney/screen/billsection/billingpage.dart';

import 'package:merchmoney/screen/cartpage/functions.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({
    super.key,
  });

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  List<Cartmodel> cartlist = [];
  double? totalprice;
  Cartmodel? selectedCart;
  @override
  void initState() {
    initalisecart();

    super.initState();
  }

  Future<void> initalisecart() async {
    await Hive.openBox<Itempage>('itembox');
    List<Cartmodel> list = await getcart();
    setState(() {
      cartlist = list;
      calculatetotalprice();
    });

    print('the length of cartlist is ${cartlist.length}');
  }

  void calculatetotalprice() {
    double total = 0;
    for (var cartitem in cartlist) {
      total +=
          int.tryParse(cartitem.currentrate ?? '')! * (cartitem.quantity ?? 0);
    }
    setState(() {
      totalprice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white38,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.white,
                  height: height * 0.16,
                  width: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cart",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF030655),
                                  fontSize: 29,
                                  fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Transactionscreen(),
                                  ));
                                },
                                icon: const Icon(
                                    Icons.production_quantity_limits_outlined))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Hey you can add what you want ! ",
                          style: GoogleFonts.openSans(
                              color: const Color(0xFF030655),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: height,
                    width: width,
                    decoration: const BoxDecoration(
                        color: Color(0xFF030655),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(21))),
                    child: cartlist.isEmpty
                        ? Center(
                            child: Text(
                              "Add Items to the Cart",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              final cart = cartlist[index];
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: height * 0.15,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: FileImage(File(
                                                      cart.imagepath ?? '')),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Name:${cart.productname}',
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'Add quanity :${cart.quantity}',
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "Category : ${cart.categorykey} ",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "Currentrate : ${cart.currentrate}",
                                            style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            child: const Icon(Icons.delete),
                                            onTap: () {
                                              print(
                                                  "Total stock when cart deleting: ${cart.item!.availablestock}");
                                              print(cart.quantity);
                                              showremove(context,
                                                  cart.cartkey ?? '', cart);
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                showupdatecart(context,
                                                    cart.cartkey ?? '');
                                              },
                                              icon: const Icon(Icons.edit))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount: cartlist.length))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: cartlist.isNotEmpty,
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total price :${totalprice.toString()}',
                  style: GoogleFonts.openSans(
                      color: const Color(0xFF030655),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => Billingaddscreen(
                        initializecart: initalisecart(),
                        totalPrice: totalprice,
                        productname: selectedCart?.productname,
                      ),
                    ).then((value) {
                      if (value == true) {
                        initalisecart();
                      }
                    });

                    print('produtname :${cartlist}');
                  },
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showremove(
    BuildContext context,
    String key,
    Cartmodel cartmodel,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove item"),
        content: const Text("Are you want to remove"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                print(
                    "Total stock when cart deleting: ${cartmodel.item!.availablestock}");
                cartmodel.item!.availablestock = (cartmodel.quantity! +
                        int.parse(cartmodel.item!.availablestock!))
                    .toString();
                print('After deletion: ${cartmodel.item!.availablestock}');
                Hive.box<Itempage>('itembox')
                    .put(cartmodel.itemkey, cartmodel.item!);
                deletecart(key);
                initalisecart();
                Navigator.of(context).pop();
              },
              child: const Text('Remove'))
        ],
      ),
    );
  }

  void showupdatecart(BuildContext context, String cartkey) async {
    TextEditingController updatequantitycontroller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Quantity"),
            content: TextField(
              controller: updatequantitycontroller,
              decoration:
                  const InputDecoration(hintText: "Enter the Quantity "),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    String updatedquantity =
                        updatequantitycontroller.text.toString();
                    if (updatedquantity.isNotEmpty) {
                      int newquantity = int.tryParse(updatedquantity) ?? 0;
                      Cartmodel updatedcart = cartlist
                          .firstWhere((cart) => cart.cartkey == cartkey);
                      updatedcart.quantity = newquantity;
                      updatecart(cartkey, updatedcart);
                      print("updated quantity ${updatedquantity}");
                      calculatetotalprice();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }
}
