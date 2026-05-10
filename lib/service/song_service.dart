import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guitar_eik/model/song_model.dart';

class SongService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get("API_URL"),
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  Future<Song> getSongDetail(int id) async {
    try {
      final response = await _dio.get('/songs/$id');
      if (response.statusCode == 200) {
        Future.delayed(Duration(milliseconds: 30000));
        return Song.fromJson(response.data);
      } else {
        throw Exception('Failed to load songs');
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }

  Future<List<Song>> searchSong(String query) async {
    try {
      final response = await _dio.get(
        "/songs/search",
        queryParameters: {"query": query},
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Song.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load songs");
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }

  Future<Map<String, dynamic>> getAllSongSummary({int page = 0}) async {
    try {
      final response = await _dio.get(
        "/songs",
        queryParameters: {'page': page, 'size': 500},
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['content'];
        bool last = response.data["last"];
        List<Song> songs = data.map((json) => Song.fromJson(json)).toList();
        return {"songs": songs, "isLast": last};
      } else {
        throw Exception('Failed to load songs');
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }
}
