// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilescreen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfilemodelAdapter extends TypeAdapter<Profilemodel> {
  @override
  final int typeId = 5;

  @override
  Profilemodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profilemodel(
      imagepath: fields[0] as String?,
      phonenumber: fields[1] as String?,
      shopname: fields[2] as String?,
      profilekey: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Profilemodel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.imagepath)
      ..writeByte(1)
      ..write(obj.phonenumber)
      ..writeByte(2)
      ..write(obj.shopname)
      ..writeByte(3)
      ..write(obj.profilekey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfilemodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
