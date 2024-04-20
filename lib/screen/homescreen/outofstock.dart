import 'dart:io';

import 'package:flutter/material.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/destinationfolder/functions.dart';

class Outofstock extends StatefulWidget {
  const Outofstock({Key? key, required this.lowstockitems}) : super(key: key);

  final List<Itempage>? lowstockitems;

  @override
  State<Outofstock> createState() => _OutofstockState();
}

class _OutofstockState extends State<Outofstock> {
  List<Itempage> lowstockitemlist = [];

  @override
  void initState() {
    super.initState();
    loadLowStockItems(); // Call method to load low stock items
  }

  Future<void> loadLowStockItems() async {
    lowstockitemlist.clear();
    List<Itempage> itemList = await getitem();
    List<Itempage> lowStockItems = getLowStockItems(itemList);
    setState(() {
      lowstockitemlist = lowStockItems;
    });
  }

  List<Itempage> getLowStockItems(List<Itempage> items) {
    return items.where((item) {
      // Parse available stock value
      int? stockValue = int.tryParse(item.availablestock ?? '');

      // Filter out items with invalid or null available stock
      return stockValue != null && stockValue <= 5;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF030655),
        centerTitle: true,
        title: const Text("Out of Stock"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: lowstockitemlist.isEmpty
            ? const Center(
                child: Text(
                  "No items are out of stock",
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            : ListView.builder(
                itemCount: lowstockitemlist.length,
                itemBuilder: (context, index) {
                  final item = lowstockitemlist[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: item.imagepath != null
                              ? FileImage(File(item.imagepath ?? ""))
                              : null
                          // child: Image.file(
                          //   File(item.imagepath ?? ""),
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                      title: Text(
                        item.productname ?? '',
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4.0),
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
