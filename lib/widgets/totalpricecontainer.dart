import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchmoney/models/transactionmodel.dart';
import 'package:merchmoney/screen/billsection/billingpage.dart';

class Totalpricecontainer extends StatefulWidget {
  const Totalpricecontainer({Key? key});

  @override
  State<Totalpricecontainer> createState() => _TotalpricecontainerState();
}

class _TotalpricecontainerState extends State<Totalpricecontainer> {
  DateTime? _selectedDate; // Track the selected date

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      width: 500,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _selectDate(context); // Show date picker on icon tap
                },
                child: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 20),
            if (transactionHistory.isEmpty)
              Text('No transactions found.',
                  style: GoogleFonts.poppins(fontSize: 22))
            else
              Text(
                _selectedDate == null
                    ? 'Total Up to Today: ${calculateTotalUpToToday()}₹'
                    : 'Total for ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}: ${calculateTotalForSelectedDate()}₹',
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }

  // Method to open date picker and set selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Calculate total amount for the selected date
  int calculateTotalForSelectedDate() {
    if (_selectedDate == null) return 0;

    int totalAmount = 0;
    for (var transaction in transactionHistory) {
      if (transaction.dateTime!.year == _selectedDate!.year &&
          transaction.dateTime!.month == _selectedDate!.month &&
          transaction.dateTime!.day == _selectedDate!.day) {
        totalAmount += transaction.totalprice!.toInt();
      }
    }
    return totalAmount;
  }

  // Calculate total amount up to today's date
  int calculateTotalUpToToday() {
    DateTime today = DateTime.now();
    int totalAmount = 0;
    for (var transaction in transactionHistory) {
      if (transaction.dateTime!.isBefore(today) ||
          (transaction.dateTime!.year == today.year &&
              transaction.dateTime!.month == today.month &&
              transaction.dateTime!.day == today.day)) {
        totalAmount += transaction.totalprice!.toInt();
      }
    }
    return totalAmount;
  }
}
