import 'package:flutter/material.dart';
import 'package:merchmoney/models/cartmodel.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/models/transactionmodel.dart';
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

class _MyWidgetState extends State<Transactionscreen> {
  @override
  void initState() {
    initalizetransaction();

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
          title: Text("Transactions"),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final transaction = transactionHistory[index];
            String formatteddate = DateTimeFormat.format(DateTime.now(),
                format: AmericanDateFormats.dayOfWeek);
            return Column(
              children: [
                ListTile(
                  title: Text(
                    'Name: ${transaction.username}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone Number: ${transaction.phonenumber}'),
                      Text('TotalPrice: ${transaction.totalprice}₹'),
                      Text('Date: ${formatteddate}'),
                      Text('Products name: ${transaction.productname}'),
                      Text('Quantity: ${transaction.quantity}'),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ), // Divider line
              ],
            );
          },
          itemCount: transactionHistory.length,
        ));
  }
}
