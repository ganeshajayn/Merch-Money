import 'package:hive/hive.dart';
import 'package:merchmoney/models/itemmodel.dart';
part 'cartmodel.g.dart';

@HiveType(typeId: 3)
class Cartmodel {
  @HiveField(0)
  int? quantity;
  @HiveField(1)
  String? productname;
  @HiveField(2)
  String? itemkey;
  @HiveField(3)
  String? cartkey;
  @HiveField(4)
  String? imagepath;
  @HiveField(5)
  String? categorykey;
  @HiveField(6)
  String? totalstock;
  @HiveField(7)
  String? currentrate;
  @HiveField(8)
  Itempage? item;
  Cartmodel({
    required this.quantity,
    required this.cartkey,
    required this.itemkey,
    required this.productname,
    required this.imagepath,
    required this.categorykey,
    required this.totalstock,
    this.currentrate,
    required this.item,
  });
}
