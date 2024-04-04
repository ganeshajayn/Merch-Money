// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactionmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionmodelAdapter extends TypeAdapter<Transactionmodel> {
  @override
  final int typeId = 4;

  @override
  Transactionmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transactionmodel(
      totalprice: fields[0] as double?,
      dateTime: fields[1] as DateTime?,
      transactionkey: fields[2] as String?,
      username: fields[3] as String?,
      phonenumber: fields[4] as String?,
      productname: (fields[6] as List?)?.cast<String>(),
      quantity: (fields[5] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Transactionmodel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.totalprice)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.transactionkey)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.phonenumber)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.productname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
