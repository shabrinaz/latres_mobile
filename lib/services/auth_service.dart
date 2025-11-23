import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart'; // Import UserModel

class AuthService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userBoxName = 'userCredentials'; // New box for user data

  Future<Box<UserModel>> _openUserBox() async {
    return await Hive.openBox<UserModel>(_userBoxName);
  }

  Future<void> saveLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, status);
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // New method for registration - menyimpan user ke Hive
  Future<void> register(String username, String password) async {
    final box = await _openUserBox();
    if (box.containsKey(username)) {
      throw Exception('Username sudah terdaftar.');
    }
    
    // NOTE: In a real app, the password should be hashed before saving
    final newUser = UserModel(username: username, password: password);
    await box.put(username, newUser);
  }

  // Update login method to authenticate against Hive data
  Future<void> login(String username, String password) async {
    final box = await _openUserBox();
    final user = box.get(username);
    
    if (user != null && user.password == password) {
      // Authentication successful
      await saveLoginStatus(true);
      return;
    }
    throw Exception('Username atau password tidak valid.');
  }

  Future<void> logout() async {
    await saveLoginStatus(false);
  }
}