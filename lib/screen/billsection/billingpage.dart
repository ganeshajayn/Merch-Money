import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:merchmoney/models/transactionmodel.dart';
import 'package:merchmoney/screen/biladd/transactiondetails.dart';
import 'package:merchmoney/screen/billsection/funcions.dart';
import 'package:date_time_format/date_time_format.dart';

class Transactionscreen extends StatefulWidget {
  const Transactionscreen({
    super.key,
  });

  @override
  State<Transactionscreen> createState() => _MyWidgetState();
}

List<Transactionmodel> transactionHistory = [];
String formatteddate = "";

class _MyWidgetState extends State<Transactionscreen> {
  @override
  void initState() {
    initalizetransaction();
    formatteddate = DateTimeFormat.format(DateTime.now(),
        format: AmericanDateFormats.dayOfWeek);
    super.initState();
  }

  Future<void> initalizetransaction() async {
    final list = await gettransaction();

    setState(() {
      transactionHistory = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF030655),
          title: Text(
            "Transactions History",
            style: GoogleFonts.roboto(fontSize: 20),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final transaction = transactionHistory[index];

            return GestureDetector(
              onTap: () {
                showbilldetails(transaction);
              },
              child: Slidable(
                  key: ValueKey(index),
                  startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            deletefunction(transaction.transactionkey ?? '');
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                        ),
                      ]),
                  child: ListTile(
                      title: Text(
                        "Name :${transaction.username}",
                        style: GoogleFonts.roboto(
                            fontSize: 23, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number: ${transaction.phonenumber}',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Total Price: ${transaction.totalprice}₹',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Date: $formatteddate',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                          ]))),
            );
          },
          itemCount: transactionHistory.length,
        ));
  }

  void deletefunction(String transactionkey) async {
    await deletetransaction(transactionkey);
  }

  void showbilldetails(Transactionmodel transaction) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TransactionDetails(
        currentrate: transaction.currentrate,
        dateTime: formatteddate,
        username: transaction.username ?? '',
        phonenumber: transaction.phonenumber ?? "",
        productname: transaction.productname,
        quantity: transaction.quantity,
        category: transaction.category,
      ),
    ));
  }
}
