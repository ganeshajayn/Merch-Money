import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionDetails extends StatefulWidget {
  final String dateTime;
  final String username;
  final String phonenumber;
  final List<String>? productname;
  final List<int>? quantity;
  final List<String>? currentrate;

  const TransactionDetails({
    Key? key,
    required this.dateTime,
    required this.username,
    required this.phonenumber,
    this.quantity,
    this.productname,
    this.currentrate,
  }) : super(key: key);

  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Invoice'),
        elevation: 0,
        backgroundColor: const Color(0xFF030655),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInvoiceHeading(),
            const SizedBox(height: 20.0),
            _buildInvoiceDetails(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceHeading() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'New Invoice',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.description,
          size: 30.0,
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildInvoiceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem('Invoice Date:', widget.dateTime),
        _buildDetailItem('Customer Name:', widget.username),
        _buildDetailItem('PhoneNumber:', widget.phonenumber),
        const SizedBox(height: 20.0),
        _itemDetailsTable(),
      ],
    );
  }

  Widget _itemDetailsTable() {
    List<DataRow> productRows = [];
    double totalPriceSum = 0.0;

    for (int i = 0; i < (widget.productname?.length ?? 0); i++) {
      String productName = widget.productname![i];
      int quantity = widget.quantity![i];
      String rate = widget.currentrate != null && i < widget.currentrate!.length
          ? widget.currentrate![i]
          : 'N/A';
      double eachPrice = quantity * (double.tryParse(rate) ?? 0);

      DataRow productRow = DataRow(
        cells: [
          DataCell(
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(
                productName,
                style: const TextStyle(fontSize: 14.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataCell(
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              constraints: const BoxConstraints(minWidth: 50),
              child: Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
          ),
          DataCell(
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              constraints: const BoxConstraints(minWidth: 50),
              child: Text(
                rate,
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
          ),
          DataCell(
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              constraints: const BoxConstraints(minWidth: 80),
              child: Text(
                eachPrice.toStringAsFixed(2),
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
          ),
        ],
      );

      productRows.add(productRow);
      totalPriceSum += eachPrice;
    }

    productRows.add(
      DataRow(
        cells: [
          DataCell(
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              constraints: const BoxConstraints(minWidth: 100),
              child: const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          DataCell(Container()),
          DataCell(Container()),
          DataCell(
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              constraints: const BoxConstraints(minWidth: 80),
              child: Text(
                totalPriceSum.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return DataTable(
      columnSpacing: 20.0,
      columns: [
        DataColumn(
          label: Text(
            'Product',
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Quantity',
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Price',
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Total Price',
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
      rows: productRows,
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
