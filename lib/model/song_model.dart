import 'package:guitar_eik/model/artist_model.dart';

class Song {
  final int id;
  final String title;
  final String? lyric;
  final int totalView;
  final List<Artist>? artists;

  Song({
    required this.id,
    required this.title,
    this.lyric,
    required this.totalView,
    this.artists,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
    id: json["id"] ?? 0,
    title: json["title"] ?? "Unknown Title",
    lyric: json["lyric"],
    totalView: json["totalView"] ?? 0,
    artists: json["artists"] == null
        ? null
        : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "lyric": lyric,
    "totalView": totalView,
    "artists": artists?.map((x) => x.toJson()).toList(),
  };
}
