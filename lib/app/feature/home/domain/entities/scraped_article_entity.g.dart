// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scraped_article_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScrapedArticleEntityAdapter extends TypeAdapter<ScrapedArticleEntity> {
  @override
  final int typeId = 0;

  @override
  ScrapedArticleEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScrapedArticleEntity(
      articleUrl: fields[0] as String,
      htmlContent: fields[1] as String,
      scrapedAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ScrapedArticleEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.articleUrl)
      ..writeByte(1)
      ..write(obj.htmlContent)
      ..writeByte(2)
      ..write(obj.scrapedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScrapedArticleEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
