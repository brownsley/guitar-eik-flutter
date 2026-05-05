import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit(super.initialTheme);
  final SharedPreferencesAsync preferences = SharedPreferencesAsync();

  Future<void> toggleTheme() async {
    final bool isDark = !state;
    emit(isDark);
    await preferences.setBool("isDarkMode", isDark);
  }
}
