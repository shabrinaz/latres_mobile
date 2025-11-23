import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/favorite_controller.dart';
import '../../../models/amiibo_model.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state!.length,
          itemBuilder: (context, index) {
            final amiibo = state[index];
            return Dismissible( 
              key: Key(amiibo.uniqueKey),
              direction: DismissDirection.horizontal,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                controller.removeFavorite(amiibo);
              },
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: amiibo.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
                title: Text(amiibo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${amiibo.amiiboSeries} - ${amiibo.gameSeries}'),
                onTap: () => Get.toNamed('/detail', arguments: amiibo),
              ),
            );
          },
        ),
        onEmpty: const Center(child: Text('Belum ada amiibo favorit.')),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text(error ?? 'Terjadi Kesalahan.')),
      ),
    );
  }
}