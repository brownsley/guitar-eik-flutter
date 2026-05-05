import 'package:guitar_eik/model/artist_detail_model.dart';
import 'package:guitar_eik/model/artist_model.dart';
import 'package:dio/dio.dart';

class ArtistService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://guitareik-api.onrender.com',
      // baseUrl: 'http://192.168.100.136:9090',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<Map<String, dynamic>> getAllArtistSummary({int page = 0}) async {
    try {
      final response = await _dio.get(
        '/artists',
        queryParameters: {'page': page, 'size': 20},
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["content"];
        bool last = response.data["last"];
        List<Artist> artists = data
            .map((json) => Artist.fromJson(json))
            .toList();

        return {"artists": artists, "isLast": last};
      } else {
        throw Exception('Failed to load artists');
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }

  Future<ArtistDetail> getArtistDetail(int id) async {
    try {
      final response = await _dio.get("/artists/$id");
      await Future.delayed(Duration(seconds: 3));
      return ArtistDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }
}
