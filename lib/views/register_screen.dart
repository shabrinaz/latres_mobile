import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<RegisterController>()) {
      Get.put(RegisterController());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Amiibo App Register')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Buat Akun Baru',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: controller.usernameTextController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_add),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordTextController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.confirmPasswordTextController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 32),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.handleRegister,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color.fromARGB(255, 213, 162, 218),
                foregroundColor: Colors.white,
              ),
              child: controller.isLoading.value 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('REGISTER', style: TextStyle(fontSize: 18)),
            )),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Get.offAllNamed('/login'),
              child: const Text('Sudah punya akun? Login di sini.'),
            ),
          ],
        ),
      ),
    );
  }
}