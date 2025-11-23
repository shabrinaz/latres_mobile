import 'package:hive_flutter/hive_flutter.dart';
import '../models/amiibo_model.dart';

class AmiiboDbService {
  static const String _boxName = 'amiiboFavorites';

  Future<Box<AmiiboModel>> openBox() async {
    return await Hive.openBox<AmiiboModel>(_boxName);
  }

  Future<void> addToFavorites(AmiiboModel amiibo) async {
    final box = await openBox();
    await box.put(amiibo.uniqueKey, amiibo);
  }

  Future<void> removeFromFavorites(AmiiboModel amiibo) async {
    final box = await openBox();
    await box.delete(amiibo.uniqueKey);
  }

  Future<List<AmiiboModel>> getFavorites() async {
    final box = await openBox();
    return box.values.toList();
  }

  Future<bool> isFavorite(AmiiboModel amiibo) async {
    final box = await openBox();
    return box.containsKey(amiibo.uniqueKey);
  }
}