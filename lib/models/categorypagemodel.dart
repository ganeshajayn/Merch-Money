import 'package:hive/hive.dart';
part 'categorypagemodel.g.dart';

@HiveType(typeId: 1)
class Categorypage {
  @HiveField(0)
  String imagepath;
  @HiveField(1)
  String categoryname;
  @HiveField(2)
  bool isassetimage;
  @HiveField(3)
  String? categorykey;
  Categorypage(
      {required this.imagepath,
      this.categorykey,
      required this.categoryname,
      required this.isassetimage});
}
