import 'package:hive/hive.dart';
import 'package:merchmoney/models/profilescreen.dart';

Future<Profilemodel?> getprofile() async {
  final profilebox = await Hive.openBox<Profilemodel>('profilebox');
  final value = profilebox.get(0);
  print("successfully gotten the data");
  return value;
}

Future<void> addprofile(Profilemodel value, String key) async {
  final profilebox = await Hive.openBox<Profilemodel>('profilebox');
  // profilebox.put(key, value);
  profilebox.put(0, value);
  print("successfully added");
}
