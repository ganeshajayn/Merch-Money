import 'package:hive/hive.dart';
part 'itemmodel.g.dart';

@HiveType(typeId: 2)
class Itempage {
  @HiveField(0)
  String? imagepath;
  @HiveField(1)
  String? productname;
  @HiveField(2)
  String? totalstock;
  @HiveField(3)
  String? currentrate;
  @HiveField(4)
  String? itemkey;
  @HiveField(5)
  String? categorykey;

  Itempage({
    required this.imagepath,
    required this.productname,
    required this.totalstock,
    required this.currentrate,
    required this.categorykey,
    required this.itemkey,
  });
}
