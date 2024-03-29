// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItempageAdapter extends TypeAdapter<Itempage> {
  @override
  final int typeId = 2;

  @override
  Itempage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Itempage(
      imagepath: fields[0] as String?,
      productname: fields[1] as String?,
      totalstock: fields[2] as String?,
      currentrate: fields[3] as String?,
      categorykey: fields[5] as String?,
      itemkey: fields[4] as String?,
      mrprate: fields[6] as String?,
      availablestock: fields[8] as String?,
      dropdown: fields[7] as String?,
      brandname: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Itempage obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.imagepath)
      ..writeByte(1)
      ..write(obj.productname)
      ..writeByte(2)
      ..write(obj.totalstock)
      ..writeByte(3)
      ..write(obj.currentrate)
      ..writeByte(4)
      ..write(obj.itemkey)
      ..writeByte(5)
      ..write(obj.categorykey)
      ..writeByte(6)
      ..write(obj.mrprate)
      ..writeByte(7)
      ..write(obj.dropdown)
      ..writeByte(8)
      ..write(obj.availablestock)
      ..writeByte(9)
      ..write(obj.brandname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItempageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
