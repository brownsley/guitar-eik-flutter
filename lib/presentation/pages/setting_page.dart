import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Colors.deepPurpleAccent;

    final bool isDarkMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          "SETTINGS",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("PREFERENCES"),
            _buildSettingTile(
              isDarkMode: isDarkMode,
              icon: isDarkMode
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              title: "Dark Mode",
              trailing: Switch(
                activeColor: accentColor,
                value: isDarkMode,
                onChanged: (val) {
                  // logic ခေါ်တဲ့အခါ read ကို သုံးပါတယ်
                  context.read<ThemeCubit>().toggleTheme();
                },
              ),
            ),

            _buildSectionTitle("MUSIC FEATURES"),
            _buildSettingTile(
              icon: Icons.music_note_rounded,
              title: "Request a Song",
              isDarkMode: isDarkMode,
            ),

            _buildSectionTitle("SUPPORT"),
            _buildSettingTile(
              icon: Icons.coffee_rounded,
              title: "Buy me a coffee",
              isDarkMode: isDarkMode,
            ),
            _buildSettingTile(
              icon: Icons.feedback_outlined,
              title: "Send Feedback",
              isDarkMode: isDarkMode,
            ),

            _buildSectionTitle("ABOUT"),
            _buildSettingTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              isDarkMode: isDarkMode,
            ),
            _buildSettingTile(
              isDarkMode: isDarkMode,
              icon: Icons.info_outline,
              title: "App Version",
              trailing: const Text(
                "1.0.0 (Beta)",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 60),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Made with ❤️ in Myanmar",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Brownlee Heim",
                    style: TextStyle(
                      color: accentColor.withOpacity(0.6),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.deepPurpleAccent,
          fontWeight: FontWeight.w900,
          fontSize: 11,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required bool isDarkMode,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.deepPurpleAccent, size: 22),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing:
          trailing ??
          const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
    );
  }
}
