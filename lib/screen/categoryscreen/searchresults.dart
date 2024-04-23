import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:merchmoney/models/itemmodel.dart';
import 'package:merchmoney/screen/itemdetails/item_details.dart';

class SearchhedResults extends StatefulWidget {
  const SearchhedResults({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchhedResults> createState() => _SearchhedResultsState();
}

class _SearchhedResultsState extends State<SearchhedResults> {
  List<Itempage> list = []; // List to hold search results
  List<Itempage> allItems = []; // List to hold all items

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF030655),
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            filled: false, // Set filled to false to use outline border
            hintText: 'Search',
            hintStyle: const TextStyle(color: Colors.white), // Hint text color
            border: UnderlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8.0), // Adjust border radius as needed
              borderSide: const BorderSide(
                color: Colors.white, // Outline border color
                width: 2.0, // Outline border width
              ),
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                searchItems(searchController.text);
              },
            ),

            fillColor: Colors.white.withOpacity(0.3),
          ),
          onChanged: (value) {
            searchItems(value);
          },
          style: const TextStyle(color: Colors.white), // Text color
        ),
      ),
      body: list.isNotEmpty
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                // Replace this with the actual item widget you want to build
                return ListTile(
                  title: Text(item.productname ?? ''),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItemDetails(item: item),
                    ));
                  },
                );
              },
            )
          : const Center(
              child: Text('No items found'),
            ),
    );
  }

  // Method to filter items based on search query
  void searchItems(String query) {
    List<Itempage> searchedList = allItems
        .where((item) =>
            item.productname!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      list = searchedList;
    });
  }

  // Method to fetch all items
  void fetchAllItems() async {
    final itemBox = await Hive.openBox<Itempage>("itembox");
    List<Itempage> itemList = itemBox.values.toList();
    setState(() {
      allItems = itemList;
      list = itemList; // Initially, set list to contain all items
    });
  }
}
