import 'package:hive/hive.dart';

import 'package:merchmoney/models/transactionmodel.dart';

Future<List<Transactionmodel>> gettransaction() async {
  final transactionbox = await Hive.openBox<Transactionmodel>('transactionbox');
  return transactionbox.values.toList();
}

Future<void> addtransaction(String key, Transactionmodel value) async {
  final transactionbox = await Hive.openBox<Transactionmodel>('transactionbox');
  transactionbox.put(key, value);
}

Future<void> deletetransaction(String key) async {
  final transactiobox = await Hive.openBox<Transactionmodel>('transactionbox');
  if (transactiobox.containsKey(key)) {
    transactiobox.delete(key);
  }
}
