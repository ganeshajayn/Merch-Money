import 'package:hive/hive.dart';
part 'profilescreen.g.dart';

@HiveType(typeId: 5)
class Profilemodel {
  @HiveField(0)
  String? imagepath;

  @HiveField(1)
  String? phonenumber;
  @HiveField(2)
  String? shopname;
  @HiveField(3)
  String? profilekey;

  Profilemodel({
    required this.imagepath,
    required this.phonenumber,
    required this.shopname,
    required this.profilekey,
  });
}
