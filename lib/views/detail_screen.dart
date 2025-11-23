import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/amiibo_model.dart';

class DetailScreen extends GetView<HomeController> {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AmiiboModel amiibo = Get.arguments as AmiiboModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Amiibo Details'),
        actions: [
          Obx(() {
            final isFav = controller.favoriteStatus[amiibo.uniqueKey] ?? false;
            return IconButton(
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.white),
              onPressed: () => controller.toggleFavorite(amiibo),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: amiibo.image,
                height: 200,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            Text(amiibo.name, style: Theme.of(context).textTheme.headlineMedium),
            const Divider(),
            _buildDetailSection('Detail Amiibo'),
            _buildDetailRow('Amiibo Series', amiibo.amiiboSeries),
            _buildDetailRow('Character', amiibo.character),
            _buildDetailRow('Game Series', amiibo.gameSeries),
            _buildDetailRow('Type', amiibo.type),
            _buildDetailRow('Head', amiibo.head),
            _buildDetailRow('Tail', amiibo.tail),
            const SizedBox(height: 24),
            _buildDetailSection('Release Dates'),
            _buildDetailRow('Australia', amiibo.getReleaseDate('au')),
            _buildDetailRow('Europe', amiibo.getReleaseDate('eu')),
            _buildDetailRow('Japan', amiibo.getReleaseDate('jp')),
            _buildDetailRow('North America', amiibo.getReleaseDate('na')),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: Get.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue)),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.normal)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}