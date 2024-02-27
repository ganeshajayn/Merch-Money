import 'package:hive/hive.dart';
import 'package:merchmoney/models/itemmodel.dart';

Future<List<Itempage>> getitem() async {
  final itembox = await Hive.openBox<Itempage>('itembox');
  final list = itembox.values.toList();

  return list;
}

Future<void> additem(Itempage value, String key) async {
  final itembox = await Hive.openBox<Itempage>('itembox');
  // final key = DateTime.now().microsecondsSinceEpoch.toString();
  // value.itemkey = key;
  print(value.itemkey);
  itembox.put(key, value);
}

Future<void> updateitem(String key, Itempage updateitem) async {
  print('update called');
  final itembox = await Hive.openBox<Itempage>('itembox');
  if (itembox.containsKey(key)) {
    print('updated');
    itembox.put(key, updateitem);
  }
}

Future<void> deleteitem(String keyForDeleting) async {
  print('key for dleete $keyForDeleting');
  final itembox = await Hive.openBox<Itempage>('itembox');
  if (itembox.containsKey(keyForDeleting)) {
    itembox.delete(keyForDeleting);
  }
}
