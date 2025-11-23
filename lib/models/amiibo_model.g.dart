part of 'amiibo_model.dart';

class AmiiboModelAdapter extends TypeAdapter<AmiiboModel> {
  @override
  final int typeId = 0;

  @override
  AmiiboModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AmiiboModel(
      amiiboSeries: fields[0] as String,
      character: fields[1] as String,
      gameSeries: fields[2] as String,
      head: fields[3] as String,
      image: fields[4] as String,
      name: fields[5] as String,
      tail: fields[6] as String,
      type: fields[7] as String,
      release: (fields[8] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AmiiboModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.amiiboSeries)
      ..writeByte(1)
      ..write(obj.character)
      ..writeByte(2)
      ..write(obj.gameSeries)
      ..writeByte(3)
      ..write(obj.head)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.tail)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.release);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmiiboModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
