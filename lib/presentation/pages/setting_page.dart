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
      backgroundColor: isDarkMode
          ? const Color(0xFF121212)
          : const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          "SETTING",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("PREFERENCES"),
              _buildSettingsGroup(isDarkMode, [
                _buildSettingTile(
                  isDarkMode: isDarkMode,
                  icon: isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  title: "Dark Mode",
                  trailing: Switch.adaptive(
                    activeColor: accentColor,
                    value: isDarkMode,
                    onChanged: (val) =>
                        context.read<ThemeCubit>().toggleTheme(),
                  ),
                ),
              ]),

              _buildSectionTitle("MUSIC FEATURES"),
              _buildSettingsGroup(isDarkMode, [
                _buildSettingTile(
                  icon: Icons.music_note_rounded,
                  title: "Request a Song",
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
              ]),

              _buildSectionTitle("SUPPORT & FEEDBACK"),
              _buildSettingsGroup(isDarkMode, [
                _buildSettingTile(
                  icon: Icons.coffee_rounded,
                  title: "Buy me a coffee",
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                _buildDivider(isDarkMode),
                _buildSettingTile(
                  icon: Icons.feedback_outlined,
                  title: "Send Feedback",
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
              ]),

              _buildSectionTitle("ABOUT"),
              _buildSettingsGroup(isDarkMode, [
                _buildSettingTile(
                  icon: Icons.privacy_tip_outlined,
                  title: "Privacy Policy",
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                _buildDivider(isDarkMode),
                _buildSettingTile(
                  isDarkMode: isDarkMode,
                  icon: Icons.info_outline,
                  title: "App Version",
                  trailing: const Text(
                    "1.0.0 (Beta)",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ]),

              const SizedBox(height: 50),
              _buildFooter(accentColor),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(bool isDarkMode, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 24, 0, 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.deepPurpleAccent,
          fontWeight: FontWeight.w900,
          fontSize: 13,
          letterSpacing: 1.2,
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.deepPurpleAccent, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      trailing:
          trailing ??
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
            size: 16,
          ),
    );
  }

  Widget _buildDivider(bool isDarkMode) {
    return Divider(
      height: 1,
      indent: 65,
      endIndent: 20,
      color: isDarkMode
          ? Colors.white.withOpacity(0.1)
          : Colors.black.withOpacity(0.05),
    );
  }

  Widget _buildFooter(Color accentColor) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Made with ❤️ in Myanmar",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "BROWNSLEY HEIM",
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
