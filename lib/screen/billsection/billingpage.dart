import 'package:flutter/material.dart';
import 'package:merchmoney/models/transactionmodel.dart';
import 'package:merchmoney/screen/billsection/funcions.dart';

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

          return ListTile(
            title: (Text('Total Price:${transaction.totalprice} ₹')),
            subtitle: Text('Date:${transaction.dateTime}'),
          );
        },
        itemCount: transactionHistory.length,
      ),
    );
  }
}
