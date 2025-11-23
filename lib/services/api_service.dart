import 'package:dio/dio.dart';
import '../models/amiibo_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://www.amiiboapi.com/api',
  ));

  Future<List<AmiiboModel>> getAllAmiibo() async {
    try {
      final response = await _dio.get('/amiibo');
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> amiiboListJson = response.data['amiibo'];
        return amiiboListJson
            .map((json) => AmiiboModel.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      print('API Error: $e');
      // Melemparkan exception dengan pesan yang jelas
      throw Exception('Failed to load Amiibo data: ${e.toString()}'); 
    }
  }
}