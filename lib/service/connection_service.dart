import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  static Future<bool> isConnected() async {
    final List<ConnectivityResult> results = await Connectivity()
        .checkConnectivity();

    if (results.contains(ConnectivityResult.none)) {
      return false;
    }
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
