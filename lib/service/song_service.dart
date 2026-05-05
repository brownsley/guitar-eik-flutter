import 'package:guitar_eik/model/song_model.dart';
import 'package:dio/dio.dart';

class SongService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://guitareik-api.onrender.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<Song> getSongDetail(int id) async {
    try {
      final response = await _dio.get('/songs/$id');
      if (response.statusCode == 200) {
        Future.delayed(Duration(milliseconds: 3000));
        return Song.fromJson(response.data);
      } else {
        throw Exception('Failed to load artists');
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }

  Future<List<Song>> getAllSongSummary() async {
    try {
      final response = await _dio.get(
        "/songs",
        queryParameters: {'page': 0, 'size': 500},
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["content"];
        return data.map((json) => Song.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load artists');
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }
}
