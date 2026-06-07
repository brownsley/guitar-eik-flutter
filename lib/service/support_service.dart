import 'package:dio/dio.dart';
import 'package:guitar_eik/service/dio_service.dart';

class SupportService {
  final Dio _dio = DioClient().dio;

  Future<void> createReport({
    required int songId,
    required String subject,
    required String description,
  }) async {
    try {
      await _dio.post(
        '/report',
        data: {
          "songId": songId,
          "subject": subject,
          "description": description,
        },
      );
    } on DioException catch (e) {
      e.message ?? "Error Occure";
    }
  }

  Future<void> createRequest({
    required String title,
    required String artist,
  }) async {
    try {
      await _dio.post('/songrequest', data: {"title": title, "artist": artist});
    } on DioException catch (e) {
      e.message ?? "Error Occure";
    }
  }

  Future<void> createSuggestion({
    required String subject,
    required String description,
  }) async {
    try {
      await _dio.post(
        '/suggestion',
        data: {"subject": subject, "description": description},
      );
    } on DioException catch (e) {
      e.message ?? "Error Occure";
    }
  }
}
