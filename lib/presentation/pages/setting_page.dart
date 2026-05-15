import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/theme/theme_cubit.dart';
import 'package:guitar_eik/presentation/widgets/setting_group.dart';
import 'package:guitar_eik/presentation/widgets/setting_header.dart';
import 'package:guitar_eik/presentation/widgets/setting_item.dart';
import 'package:guitar_eik/presentation/widgets/utils/form_dailog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool isDarkMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Text(
          "SETTING",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 16,
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingHeader(title: "PREFERENCES"),
            SettingGroup(
              items: [
                SettingItem(
                  title: "Dark Mode",
                  icon: isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  trailing: Switch.adaptive(
                    activeColor: colorScheme.primary,
                    value: isDarkMode,
                    onChanged: (val) =>
                        context.read<ThemeCubit>().toggleTheme(),
                  ),
                ),
              ],
            ),

            const SettingHeader(title: "MUSIC FEATURES"),
            SettingGroup(
              items: [
                SettingItem(
                  title: "Request a Song",
                  icon: Icons.music_note_rounded,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => FormDailog(
                        title: "Request Song",
                        subjectLabel: "Song Name",
                        descLabel: "Artist Name",
                        onSubmit: () {},
                      ),
                    );
                  },
                ),
              ],
            ),

            const SettingHeader(title: "SUPPORT & FEEDBACK"),
            SettingGroup(
              items: [
                SettingItem(
                  title: "Buy me a coffee",
                  icon: Icons.coffee_rounded,
                  onTap: () {},
                ),
                SettingItem(
                  title: "Send Feedback",
                  icon: Icons.feedback_outlined,
                  onTap: () {},
                  showDivider: false,
                ),
              ],
            ),

            const SettingHeader(title: "ABOUT"),
            SettingGroup(
              items: [
                SettingItem(
                  title: "Privacy Policy",
                  icon: Icons.privacy_tip_outlined,
                  onTap: () {},
                ),
                SettingItem(
                  title: "Terms of Service",
                  icon: Icons.description_outlined,
                  onTap: () {},
                ),
                SettingItem(
                  title: "App Version",
                  icon: Icons.info_outline,
                  showDivider: false,
                  trailing: Text(
                    "1.0.0 (Beta)",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
