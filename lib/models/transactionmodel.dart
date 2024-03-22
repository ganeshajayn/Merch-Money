import 'package:hive/hive.dart';
part 'transactionmodel.g.dart';

@HiveType(typeId: 4)
class Transactionmodel {
  @HiveField(0)
  double? totalprice;
  @HiveField(1)
  DateTime? dateTime;
  @HiveField(2)
  String? transactionkey;
  @HiveField(3)
  String? username;
  @HiveField(4)
  String? phonenumber;
  @HiveField(5)
  String? quantity;
  @HiveField(6)
  String? productname;
  Transactionmodel(
      {required this.totalprice,
      required this.dateTime,
      required this.transactionkey,
      this.username,
      this.phonenumber,
      required this.productname,
      this.quantity});
}
