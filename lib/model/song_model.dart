class Song {
  final int id;
  final String title;
  final String? lyric;
  final int totalView;
  final String cover;
  final List<String>? artists;

  Song({
    required this.id,
    required this.title,
    required this.cover,
    this.lyric,
    required this.totalView,
    this.artists,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
    id: json["id"] ?? 0,
    title: json["title"] ?? "Unknown Title",
    cover: json["cover"] ?? "",
    lyric: json["lyric"],
    totalView: json["totalView"] ?? 0,
    artists: json["artists"] == null
        ? null
        : List<String>.from(json["artists"].map((x) => x["name"].toString())),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "cover": cover,
    "lyric": lyric,
    "totalView": totalView,
    "artists": artists,
  };
}
