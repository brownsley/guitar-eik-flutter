import 'package:dio/dio.dart';
import 'package:guitar_eik/model/artist_detail_model.dart';
import 'package:guitar_eik/model/artist_model.dart';
import 'package:guitar_eik/service/dio_service.dart';

class ArtistService {
  final Dio _dio = DioClient().dio;

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

  Future<List<Artist>> searchArtist(String query) async {
    try {
      final response = await _dio.get(
        "/artists/search",
        queryParameters: {'query': query},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Artist.fromJson(json)).toList();
      } else {
        throw "Server error: ${response.statusCode}";
      }
    } on DioException catch (e) {
      throw e.message ?? "Error occured";
    }
  }

  Future<ArtistDetail> getArtistDetail(int id) async {
    try {
      final response = await _dio.get("/artists/$id");
      return ArtistDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw e.message ?? "Error occurred";
    }
  }
}
