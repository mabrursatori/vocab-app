// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabAdapter extends TypeAdapter<Vocab> {
  @override
  final int typeId = 1;

  @override
  Vocab read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vocab(
      english: fields[0] as String,
      indonesia: fields[1] as String,
      englishExample: fields[2] as String,
      indoExample: fields[3] as String,
      type: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Vocab obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.english)
      ..writeByte(1)
      ..write(obj.indonesia)
      ..writeByte(2)
      ..write(obj.englishExample)
      ..writeByte(3)
      ..write(obj.indoExample)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
