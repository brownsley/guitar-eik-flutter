class Album {
  final String cover;
  final int id;
  final String name;

  Album({required this.cover, required this.id, required this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      cover: json["cover"] ?? "",
      id: json["id"] ?? 0,
      name: json["name"] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() => {"cover": cover, "id": id, "name": name};
}
