import 'package:flutter/material.dart';

class Transactiondetails extends StatefulWidget {
  const Transactiondetails(
      {super.key,
      required this.username,
      required this.phonenumber,
      this.quantity,
      this.productname,
      this.totalprice});
  final String username;
  final String phonenumber;
  final String? totalprice;
  final List<int>? quantity;
  final List<String>? productname;
  @override
  State<Transactiondetails> createState() => _TransactiondetailsState();
}

class _TransactiondetailsState extends State<Transactiondetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF030655),
        centerTitle: true,
        title: const Text("Transaction Details"),
      ),
      body: Column(
        children: [
          Text("Name:${widget.username} "),
          ListView.builder(
              itemCount: widget.productname!.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text(
                      '${widget.productname![index]}-${widget.quantity![index]}'),
                  subtitle: Text(''),
                );
              }))
        ],
      ),
    );
  }
}
