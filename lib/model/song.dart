import 'package:hive/hive.dart';

part 'song.g.dart';

@HiveType(typeId: 0)
class Song extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<String> artists;

  @HiveField(3)
  final String cover;

  Song({
    required this.id,
    required this.title,
    required this.artists,
    required this.cover,
  });
}
