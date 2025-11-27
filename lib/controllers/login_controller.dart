import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    checkAndRedirect();
  }
  
  void checkAndRedirect() async {
    final isLoggedIn = await _authService.checkLoginStatus();
    if (isLoggedIn) {
      if (Get.currentRoute != '/') {
        Get.offAllNamed('/'); 
      }
    }
  }

  Future<void> handleLogin() async {
    isLoading(true);
    try {
      await _authService.login(
        usernameTextController.text,
        passwordTextController.text,
      );

      Get.offAllNamed('/'); 
    } catch (e) {
      Get.snackbar(
        'login gagal',
        'Cek kredensial kembali',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}