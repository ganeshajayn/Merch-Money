import 'package:flutter/material.dart';
import 'package:merchmoney/models/transactionmodel.dart';
import 'package:merchmoney/screen/billsection/billingpage.dart';
import 'package:merchmoney/screen/billsection/funcions.dart';
import 'package:merchmoney/screen/cartpage/functions.dart';

import 'package:merchmoney/widgets/textfield.dart';

class Billingaddscreen extends StatefulWidget {
  const Billingaddscreen({
    super.key,
    required this.totalPrice,
    required this.productname,
    required this.initializecart,
  });
  final double? totalPrice;
  final String? productname;
  final dynamic initializecart;
  @override
  State<Billingaddscreen> createState() => _BillingaddscreenState();
}

TextEditingController usernamecontroller = TextEditingController();
TextEditingController phonenumbercontroller = TextEditingController();

class _BillingaddscreenState extends State<Billingaddscreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Checkout"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: usernamecontroller,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: phonenumbercontroller,
            decoration: const InputDecoration(labelText: "Phone Number"),
          ),
        ],
      ),
      actions: [
        ElevatedButtonnWidget(
            onpressed: () {
              if (usernamecontroller.text.isEmpty ||
                  phonenumbercontroller.text.isEmpty) {
                // Show a dialog or a snackbar indicating that fields are empty
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Invalid Input"),
                      content: const Text("Please Enter valid details"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Proceed with saving the transaction
                String key = DateTime.now().microsecondsSinceEpoch.toString();
                final value = Transactionmodel(
                  username: usernamecontroller.text,
                  phonenumber: phonenumbercontroller.text,
                  totalprice: widget.totalPrice,
                  dateTime: DateTime.now(),
                  transactionkey: key,
                  productname: widget.productname,
                );
                addtransaction(key, value);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Transactionscreen(),
                ));
                clearBox();
                widget.initializecart;
              }
            },
            buttontext: "Save"),
        TextButtonWidget(
            onpressed: () {
              String? username = usernamecontroller.text.isNotEmpty
                  ? usernamecontroller.text
                  : "Unknown";
              String? phoneNumber = phonenumbercontroller.text.isNotEmpty
                  ? phonenumbercontroller.text
                  : "N/A";

              // Navigate to the next screen
              String key = DateTime.now().microsecondsSinceEpoch.toString();
              final value = Transactionmodel(
                username: username,
                phonenumber: phoneNumber,
                totalprice: widget.totalPrice,
                dateTime: DateTime.now(),
                transactionkey: key,
                productname: widget.productname,
              );
              addtransaction(key, value);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Transactionscreen(),
              ));
              clearBox();
              widget.initializecart;
            },
            textbutton: "Skip & Continue")
      ],
    );
  }
}
