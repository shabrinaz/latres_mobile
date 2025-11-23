import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/amiibo_model.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nitendo Amiibo List'),
        actions: [
          // Tombol Logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state!.length,
          itemBuilder: (context, index) {
            final amiibo = state[index];
            return _AmiiboListItem(amiibo: amiibo, controller: controller);
          },
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(child: Text('Error: $error')),
        onEmpty: const Center(child: Text('Tidak ada data Amiibo.')),
      ),
    );
  }
}

class _AmiiboListItem extends StatelessWidget {
  final AmiiboModel amiibo;
  final HomeController controller;
  
  const _AmiiboListItem({required this.amiibo, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: amiibo.image,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(amiibo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${amiibo.amiiboSeries} - ${amiibo.gameSeries}'),
      trailing: Obx(() {
        final isFav = controller.favoriteStatus[amiibo.uniqueKey] ?? false;
        return IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.grey),
          onPressed: () => controller.toggleFavorite(amiibo),
        );
      }),
      onTap: () => Get.toNamed('/detail', arguments: amiibo),
    );
  }
}