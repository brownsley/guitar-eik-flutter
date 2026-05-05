class Artist {
  final int id;
  final String name;
  final String? avatar;
  final String? socialLink;
  final int? totalTrack;

  Artist({
    required this.id,
    required this.name,
    this.avatar,
    this.socialLink,
    this.totalTrack,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"] ?? 0,
    name: json["name"] ?? "Unknown",
    avatar: json["avatar"],
    socialLink: json["socialLink"],
    totalTrack: json["totalTrack"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "socialLink": socialLink,
    "totalTrack": totalTrack,
  };
}
