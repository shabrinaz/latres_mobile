import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/favorite_controller.dart';
import 'controllers/home_controller.dart';
import 'views/favorite_screen.dart';
import 'views/home_screen.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = 0.obs;
     
    final List<Widget> screens = [
      GetBuilder<HomeController>(builder: (_) => const HomeScreen()),
      GetBuilder<FavoriteController>(builder: (_) => const FavoriteScreen()),
    ];

    return Scaffold(
      body: Obx(() => screens[currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (index) {
            currentIndex.value = index;
            if (index == 1) {
              Get.find<FavoriteController>().fetchFavorites(); 
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
          ],
        ),
      ),
    );
  }
}