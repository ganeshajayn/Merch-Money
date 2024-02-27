// ignore_for_file: file_names

import 'package:hive/hive.dart';
import 'package:merchmoney/models/categorypagemodel.dart';

Future<List<Categorypage>> getcategories() async {
  final categorybox = await Hive.openBox<Categorypage>('categorybox');
  return categorybox.values.toList();
}

Future<void> addcategory(Categorypage value) async {
  final categorybox = await Hive.openBox<Categorypage>('categorybox');
  final key = DateTime.now().microsecondsSinceEpoch.toString();
  value.categorykey = key;
  categorybox.put(key, value);
}

Future<void> updatecategory(String key, Categorypage updatecategory) async {
  final categorybox = await Hive.openBox<Categorypage>('categorybox');

  if (categorybox.containsKey(key)) {
    categorybox.put(key, updatecategory);
  }
}

Future<void> deletcategory(String key) async {
  final categorybox = await Hive.openBox<Categorypage>('categorybox');
  if (categorybox.containsKey(key)) {
    categorybox.delete(key);
  }
}
