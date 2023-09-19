// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImcAdapter extends TypeAdapter<Imc> {
  @override
  final int typeId = 0;

  @override
  Imc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Imc(
      altura: fields[1] as double,
      peso: fields[0] as double,
      resultado: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Imc obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.peso)
      ..writeByte(1)
      ..write(obj.altura)
      ..writeByte(2)
      ..write(obj.resultado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImcAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
