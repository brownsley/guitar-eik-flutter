import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit(super.initialTheme);

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final bool isDark = !state;
    emit(isDark);

    await prefs.setBool("isDarkMode", isDark);
  }

  void setLightTheme() {
    emit(false);
  }
}
