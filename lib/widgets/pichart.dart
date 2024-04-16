import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
      future: Hive.openBox<Transactionmodel>(
          'transactionbox'), // Open transactions box
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final transactionBox = snapshot.data!;
            Map<String, double> categorySales = {};

            // Calculate total sales per category
            for (var transaction in transactionBox.values) {
              List<String>? categories = transaction.category;
              double totalPrice = transaction.totalprice ?? 0.0;

              if (categories != null && categories.isNotEmpty) {
                for (String category in categories) {
                  if (categorySales.containsKey(category)) {
                    categorySales[category] =
                        (categorySales[category] ?? 0) + totalPrice;
                  } else {
                    categorySales[category] = totalPrice;
                  }
                }
              }
            }

            // Sort categories by total sales in descending order
            List<MapEntry<String, double>> sortedCategories =
                categorySales.entries.toList()
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
          } else {
            return const Center(
                child: Text(
              'No transactions found.',
              style: TextStyle(color: Colors.black),
            ));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildPieChart(Map<String, double> categorySales) {
    double desiredRadius = 100.0;

    List<PieChartSectionData> pieChartData = [];
    List<Color> colorPalette = _generateColorPalette(categorySales.length);

    int colorIndex = 0;
    categorySales.forEach((category, sales) {
      Color categoryColor = colorPalette[colorIndex % colorPalette.length];
      pieChartData.add(PieChartSectionData(
        value: sales,
        title: category,
        color: categoryColor,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ));
      colorIndex++;
    });

    return Center(
      child: SizedBox(
        width: desiredRadius * 2,
        height: desiredRadius * 2,
        child: PieChart(
          PieChartData(
            sections: pieChartData,
            sectionsSpace: 0,
            centerSpaceRadius: desiredRadius,
          ),
          swapAnimationDuration: const Duration(milliseconds: 750),
          swapAnimationCurve: Curves.easeInOutQuint,
        ),
      ),
    );
  }

  List<Color> _generateColorPalette(int numberOfColors) {
    List<Color> colorPalette = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.yellow,
      Colors.teal,
      Colors.pink,
      Colors.deepOrange,
      Colors.indigo,
    ];

    return colorPalette.take(numberOfColors).toList();
  }
}
