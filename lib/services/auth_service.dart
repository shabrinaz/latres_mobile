import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'isLoggedIn';

  Future<void> saveLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, status);
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> login(String username, String password) async {
    // Simulasi otentikasi: Login berhasil jika username dan password tidak kosong
    if (username.isNotEmpty && password.isNotEmpty) {
      await saveLoginStatus(true);
      return;
    }
    throw Exception('Invalid username or password');
  }

  Future<void> logout() async {
    await saveLoginStatus(false);
  }
}