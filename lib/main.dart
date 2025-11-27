import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controllers/favorite_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/register_controller.dart'; 
import 'services/notification_service.dart';
import 'services/auth_service.dart';
import 'models/amiibo_model.dart';
import 'models/user_model.dart'; 
import 'main_wrapper.dart';
import 'views/detail_screen.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  Hive.registerAdapter(AmiiboModelAdapter()); 
  Hive.registerAdapter(UserModelAdapter()); 
  
  Get.put(NotificationService()).initialize();
  Get.put(AuthService());
  
  final AuthService authService = Get.find<AuthService>();
  final isLoggedIn = await authService.checkLoginStatus();
  
  // 4. Inisialisasi Controllers
  Get.put(HomeController());
  Get.put(FavoriteController());
  Get.put(LoginController());
  Get.put(RegisterController()); 
  
  runApp(AmiiboApp(initialRoute: isLoggedIn ? '/' : '/login'));
}

class AmiiboApp extends StatelessWidget {
  final String initialRoute;
  const AmiiboApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nitendo Amiibo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 210, 157, 231),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      initialRoute: initialRoute, 
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/', page: () => const MainWrapper()),
        GetPage(name: '/detail', page: () => const DetailScreen()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}