import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/amiibo_model.dart';
import '../services/api_service.dart';
import '../services/amiibo_db_service.dart';
import '../services/notification_service.dart';
import '../services/auth_service.dart'; 
import 'favorite_controller.dart'; 

class HomeController extends GetxController with StateMixin<List<AmiiboModel>> {
  final ApiService _apiService = ApiService();
  final AmiiboDbService _dbService = AmiiboDbService();
  final NotificationService _notificationService = Get.find<NotificationService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxMap<String, bool> favoriteStatus = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.currentRoute != '/login') {
      fetchAmiiboData();
    }
  }

  Future<void> fetchAmiiboData() async {
    change(null, status: RxStatus.loading());
    try {
      final data = await _apiService.getAllAmiibo();
      await updateFavoriteStatuses(data);
      change(data, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
  
  Future<void> updateFavoriteStatuses(List<AmiiboModel> amiiboList) async {
    for (var amiibo in amiiboList) {
      final isFav = await _dbService.isFavorite(amiibo);
      favoriteStatus[amiibo.uniqueKey] = isFav;
    }
  }

  Future<void> toggleFavorite(AmiiboModel amiibo) async {
    final isFav = favoriteStatus[amiibo.uniqueKey] ?? false;
    
    if (isFav) {
      await _dbService.removeFromFavorites(amiibo);
    } else {
      await _dbService.addToFavorites(amiibo);
      await _notificationService.showFavoriteNotification(amiibo.name); 
    }
    
    favoriteStatus[amiibo.uniqueKey] = !isFav;
    Get.find<FavoriteController>().fetchFavorites(); 
  }
  
  Future<void> handleLogout() async {
    await _authService.logout();
    Get.offAllNamed('/login'); 
  }
}