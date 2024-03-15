import 'package:hive/hive.dart';
import 'package:merchmoney/models/cartmodel.dart';

Future<List<Cartmodel>> getcart() async {
  final cartbox = await Hive.openBox<Cartmodel>('cartbox');
  return cartbox.values.toList();
}

Future<void> addcart(String key, Cartmodel value) async {
  final cartbox = await Hive.openBox<Cartmodel>('cartbox');
  if (cartbox.containsKey(key)) {
    final existingcartitem = cartbox.get(key);
    final updatedquantity =
        (existingcartitem?.quantity ?? 0) + (value.quantity ?? 0);

    existingcartitem?.quantity = updatedquantity;
    cartbox.put(key, existingcartitem!);
  } else {
    cartbox.put(key, value);
  }
}

Future<void> deletecart(String key) async {
  final cartbox = await Hive.openBox<Cartmodel>('cartbox');
  if (cartbox.containsKey(key)) {
    cartbox.delete(key);
  }
}

// Future<void> clearBox() async {
//   // Open the Hive box
//   final cartbox = await Hive.openBox<Cartmodel>('cartbox');

//   // Clear all values in the box
//   await cartbox.clear();
// }
