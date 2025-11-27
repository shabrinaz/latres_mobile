import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  
  var isLoading = false.obs;

  @override
  void onClose() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.onClose();
  }

  Future<void> handleRegister() async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;
    final confirmPassword = confirmPasswordTextController.text;

    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Registrasi gagal', 'Semua kolom harus diisi.', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Registrasi gagal', 'Konfirmasi password tidak cocok.', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    
    isLoading(true);
    try {
      await _authService.register(username, password);
      
      Get.snackbar(
        'Registrasi berhasil', 
        'Pendaftaran berhasil! Silakan login.', 
        backgroundColor: Colors.green, 
        colorText: Colors.white
      );
      
      Get.offAllNamed('/login'); 
    } catch (e) {
      Get.snackbar(
        'Registrasi gagal',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}