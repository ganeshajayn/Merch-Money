// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorypagemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategorypageAdapter extends TypeAdapter<Categorypage> {
  @override
  final int typeId = 1;

  @override
  Categorypage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categorypage(
      imagepath: fields[0] as String,
      categoryname: fields[1] as String,
      isassetimage: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Categorypage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imagepath)
      ..writeByte(1)
      ..write(obj.categoryname)
      ..writeByte(2)
      ..write(obj.isassetimage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategorypageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
