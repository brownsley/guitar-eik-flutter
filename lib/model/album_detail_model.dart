import 'package:guitar_eik/model/artist_model.dart';
import 'package:guitar_eik/model/song_model.dart';

class AlbumDetail {
  final int id;
  final String name;
  final String cover;
  final int totalSongs;
  final List<Artist> artists;
  final List<Song> songs;

  AlbumDetail({
    required this.id,
    required this.name,
    required this.cover,
    required this.totalSongs,
    required this.artists,
    required this.songs,
  });

  factory AlbumDetail.fromJson(Map<String, dynamic> json) => AlbumDetail(
    id: json["id"] ?? 0,
    name: json["name"] ?? "Unknown Album",
    cover: json["cover"] ?? "",
    totalSongs: json["totalSongs"] ?? "",
    artists: json["artists"] == null
        ? []
        : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    songs: json["songs"] == null
        ? []
        : List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cover": cover,
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
  };
}
