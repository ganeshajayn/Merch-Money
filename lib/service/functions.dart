import 'package:hive/hive.dart';
import 'package:merchmoney/models/categorypagemodel.dart';

Future<List<Categorypage>> getcategories() async {
  final categorybox = await Hive.openBox<Categorypage>('categorybox');
  return categorybox.values.toList();
}

Future<void> addcategory(Categorypage value) async {
  final categorybox = await Hive.openBox<Categorypage>('categorybox');
  final timeKey = DateTime.now().millisecondsSinceEpoch;
  String key = timeKey.toString();
  categorybox.put(key, value);
}
