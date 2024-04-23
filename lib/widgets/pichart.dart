import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:merchmoney/models/transactionmodel.dart';

class MyPieChart extends StatefulWidget {
  const MyPieChart({Key? key}) : super(key: key);

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box<Transactionmodel>>(
      future: Hive.openBox<Transactionmodel>('transactionbox'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'No transactions found.',
              style: GoogleFonts.poppins(fontSize: 22),
            ),
          ));
        }

        final transactionBox = snapshot.data!;
        Map<String, double> categorySales = {};

        // Calculate total sales per category
        for (var transaction in transactionBox.values) {
          List<String>? categories = transaction.category;
          double totalPrice = transaction.totalprice ?? 0.0;

          if (categories != null && categories.isNotEmpty) {
            for (String category in categories) {
              categorySales.update(category, (value) => value + totalPrice,
                  ifAbsent: () => totalPrice);
            }
          }
        }

        if (categorySales.isEmpty) {
          return Center(
              child: Text(
            'No transactions found.',
            style: GoogleFonts.poppins(fontSize: 22),
          ));
        }

        // Sort categories by total sales in descending order
        List<MapEntry<String, double>> sortedCategories = categorySales.entries
            .toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        // Take the top 4 categories, and sum the rest under "Others"
        Map<String, double> groupedCategories = {};
        for (int i = 0; i < sortedCategories.length; i++) {
          if (i < 4) {
            groupedCategories[sortedCategories[i].key] =
                sortedCategories[i].value;
          } else {
            groupedCategories.update(
                'Others', (value) => value + sortedCategories[i].value,
                ifAbsent: () => sortedCategories[i].value);
          }
        }

        return _buildPieChart(groupedCategories);
      },
    );
  }

  Widget _buildPieChart(Map<String, double> categorySales) {
    double desiredRadius = 80.0;

    List<PieChartSectionData> pieChartData = [];
    List<Color> colorPalette = _generateColorPalette(categorySales.length);

    int colorIndex = 0;
    double totalSales =
        categorySales.values.fold(0, (previous, current) => previous + current);

    categorySales.forEach((category, sales) {
      Color categoryColor = colorPalette[colorIndex % colorPalette.length];

      // Create a section for the pie chart
      pieChartData.add(
        PieChartSectionData(
          value: sales,
          color: categoryColor,
          title: '\$$totalSales.toStringAsFixed(2)}', // Display sales as title
          titleStyle: const TextStyle(
            fontSize: 0, // Hide the default title
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      colorIndex++;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: desiredRadius * 10,
              height: desiredRadius * 2,
              child: PieChart(
                PieChartData(
                  sections: pieChartData,
                  sectionsSpace: 0,
                  centerSpaceRadius: desiredRadius,
                ),
                swapAnimationDuration: const Duration(milliseconds: 950),
                swapAnimationCurve: Curves.easeInOutQuint,
              ),
            ),
            // Display total sales value at the center
            Text(
              '₹$totalSales',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: categorySales.keys.map((category) {
            Color categoryColor =
                colorPalette[colorIndex % colorPalette.length];
            colorIndex++;
            return _buildLegendItem(category, categoryColor);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String category, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            category,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _generateColorPalette(int numberOfColors) {
    List<Color> colorPalette = [
      Colors.pink, // Pink
      Colors.deepOrange, // Orange
      Colors.indigo, // Indigo
      Colors.blue, // Blue
      Colors.green, // Green
      Colors.teal, // Teal
      Colors.purple, // Purple
      Colors.amber, // Amber
    ];

    return List.generate(numberOfColors, (index) {
      return colorPalette[index % colorPalette.length];
    });
  }
}
