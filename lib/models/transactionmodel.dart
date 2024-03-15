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
  Transactionmodel(
      {required this.totalprice,
      required this.dateTime,
      required this.transactionkey});
}
