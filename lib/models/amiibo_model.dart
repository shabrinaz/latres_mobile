import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'amiibo_model.g.dart';

@HiveType(typeId: 0)
class AmiiboModel extends HiveObject {
  @HiveField(0)
  final String amiiboSeries;
  @HiveField(1)
  final String character;
  @HiveField(2)
  final String gameSeries;
  @HiveField(3)
  final String head;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final String name;
  @HiveField(6)
  final String tail;
  @HiveField(7)
  final String type;
  @HiveField(8)
  final Map<String, String> release;

  AmiiboModel({
    required this.amiiboSeries,
    required this.character,
    required this.gameSeries,
    required this.head,
    required this.image,
    required this.name,
    required this.tail,
    required this.type,
    required this.release,
  });

  factory AmiiboModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> rawRelease =
        json['release'] as Map<String, dynamic>? ?? {};

    final Map<String, String> safeRelease = {};
    rawRelease.forEach((key, value) {
      if (value != null) {
        safeRelease[key.toString()] = value.toString();
      }
    });

    return AmiiboModel(
      amiiboSeries: json['amiiboSeries']?.toString() ?? 'N/A',
      character: json['character']?.toString() ?? 'N/A',
      gameSeries: json['gameSeries']?.toString() ?? 'N/A',
      head: json['head']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      name: json['name']?.toString() ?? 'N/A',
      tail: json['tail']?.toString() ?? '',
      type: json['type']?.toString() ?? 'N/A',
      release: safeRelease,
    );
  }

  String get uniqueKey => '$head-$tail';

  String getReleaseDate(String region) {
    final String? dateString = release[region];
    if (dateString == null) return 'N/A';

    try {
      final date = DateFormat('yyyy-MM-dd').parse(dateString);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
