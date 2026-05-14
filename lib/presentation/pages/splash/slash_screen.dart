import 'package:flutter/material.dart';
import 'package:guitar_eik/presentation/widgets/utils/error_page.dart';
import 'package:guitar_eik/service/connection_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkConnectionAndNavigate();
  }

  Future<void> _checkConnectionAndNavigate() async {
    await Future.delayed(const Duration(seconds: 1));

    bool isConnected = await ConnectionService.isConnected();

    if (mounted) {
      if (isConnected) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ErrorPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: Stack(
        children: [
          Center(
            child: Text(
              "GuitarEik",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Developed by",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Brownsley Heim",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent.withOpacity(0.8),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
