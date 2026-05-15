import 'package:dio/dio.dart';
import 'package:guitar_eik/service/dio_service.dart';

class SupportService {
  final Dio _dio = DioClient().dio;

  Future<void> createRepost({
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
}
