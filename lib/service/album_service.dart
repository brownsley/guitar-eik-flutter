import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guitar_eik/model/album_model.dart';

class AlbumService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get("API_URL"),
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<List<Album>> getAllAlbum() async {
    try {
      final response = await _dio.get("/album");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Album.fromJson(json)).toList();
      } else {
        throw "Server returned status code: ${response.statusCode}";
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }
}
