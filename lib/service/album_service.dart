import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guitar_eik/model/album_detail_model.dart';
import 'package:guitar_eik/model/album_model.dart';

class AlbumService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get("API_URL"),
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  Future<Map<String, dynamic>> getAllAlbum({int page = 0}) async {
    try {
      final response = await _dio.get(
        "/albums",
        queryParameters: {'page': page, 'size': 20},
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["content"];
        bool last = response.data["last"];
        List<Album> albums = data.map((json) => Album.fromJson(json)).toList();
        return {"albums": albums, "isLast": last};
      } else {
        throw "Server returned status code: ${response.statusCode}";
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }

  Future<AlbumDetail> getAlbumDetail(int id) async {
    try {
      final response = await _dio.get("/albums/$id");
      return AlbumDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }

  Future<List<Album>> searchAlbum(String query) async {
    try {
      final response = await _dio.get(
        "/albums/search",
        queryParameters: {'query': query},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Album.fromJson(json)).toList();
      } else {
        throw "Server error: ${response.statusCode}";
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }
}
