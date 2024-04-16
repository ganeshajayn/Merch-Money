import 'package:hive/hive.dart';
import 'package:merchmoney/models/profilescreen.dart';

Future<List> getprofiles() async {
  final profilebox = await Hive.openBox<Profilemodel>("profilebox");
  return profilebox.values.toList();
}

Future<void> addprofile(String key, Profilemodel value) async {
  final profilebox = await Hive.openBox<Profilemodel>("profilebox");
  final key = DateTime.now().microsecondsSinceEpoch.toString();
  value.profilekey = key;
  profilebox.put(key, value);
}
