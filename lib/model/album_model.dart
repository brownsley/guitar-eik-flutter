import 'dart:convert';

List<Album> albumFromJson(String str) =>
    List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

String albumToJson(List<Album> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Album {
  String cover;
  int id;
  String name;

  Album({required this.cover, required this.id, required this.name});

  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(cover: json["cover"], id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"cover": cover, "id": id, "name": name};
}
