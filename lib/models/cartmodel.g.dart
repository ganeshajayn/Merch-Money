// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartmodelAdapter extends TypeAdapter<Cartmodel> {
  @override
  final int typeId = 3;

  @override
  Cartmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cartmodel(
      quantity: fields[0] as int?,
      cartkey: fields[3] as String?,
      itemkey: fields[2] as String?,
      productname: fields[1] as String?,
      imagepath: fields[4] as String?,
      categorykey: fields[5] as String?,
      totalstock: fields[6] as String?,
      currentrate: fields[7] as String?,
      item: fields[8] as Itempage?,
    );
  }

  @override
  void write(BinaryWriter writer, Cartmodel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.quantity)
      ..writeByte(1)
      ..write(obj.productname)
      ..writeByte(2)
      ..write(obj.itemkey)
      ..writeByte(3)
      ..write(obj.cartkey)
      ..writeByte(4)
      ..write(obj.imagepath)
      ..writeByte(5)
      ..write(obj.categorykey)
      ..writeByte(6)
      ..write(obj.totalstock)
      ..writeByte(7)
      ..write(obj.currentrate)
      ..writeByte(8)
      ..write(obj.item);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
