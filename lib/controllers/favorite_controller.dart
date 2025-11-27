import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/amiibo_model.dart';
import '../services/amiibo_db_service.dart';
import 'home_controller.dart'; 

class FavoriteController extends GetxController with StateMixin<List<AmiiboModel>> {
  final AmiiboDbService _dbService = AmiiboDbService();

  @override
  void onReady() {
    super.onReady();
    if (Get.currentRoute != '/login') {
      fetchFavorites();
    }
  }
  
  void fetchFavorites() async {
    change(null, status: RxStatus.loading());
    try {
      final data = await _dbService.getFavorites();
      
      if (data.isEmpty) {
        change(data, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error('Gagal memuat daftar favorit.'));
    }
  }

  Future<void> removeFavorite(AmiiboModel amiibo) async {
    await _dbService.removeFromFavorites(amiibo);
    fetchFavorites(); 

    Get.snackbar(
      '',
      '${amiibo.name} dihapus dari favorit',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black54,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      messageText: Text('${amiibo.name} dihapus dari favorit', style: const TextStyle(color: Colors.white)),
      titleText: Container(), 
    );
    
    Get.find<HomeController>().favoriteStatus[amiibo.uniqueKey] = false;
  }
}