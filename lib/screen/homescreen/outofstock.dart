import 'dart:io';

import 'package:flutter/material.dart';
import 'package:merchmoney/models/itemmodel.dart';

class Outofstock extends StatefulWidget {
  const Outofstock({Key? key, required this.lowstockitems}) : super(key: key);

  final List<Itempage>? lowstockitems;

  @override
  State<Outofstock> createState() => _OutofstockState();
}

class _OutofstockState extends State<Outofstock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF030655),
        centerTitle: true,
        title: Text("Out of Stock"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: widget.lowstockitems == null || widget.lowstockitems!.isEmpty
            ? Center(
                child: Text(
                  "No items are out of stock",
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            : ListView.builder(
                itemCount: widget.lowstockitems!.length,
                itemBuilder: (context, index) {
                  final item = widget.lowstockitems![index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: ClipRRect(
                          child: Image.file(
                            File(item.imagepath ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        item.productname ?? '',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.0),
                          Text("Brand: ${item.brandname ?? 'N/A'}"),
                          Text("Available Stock: ${item.availablestock}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
