import 'dart:convert'; 
import 'package:http/http.dart' as http; 
import '../models/amiibo_model.dart';

class ApiService {
  // Hapus inisialisasi Dio
  final String _baseUrl = 'https://www.amiiboapi.com/api/amiibo';

  Future<List<AmiiboModel>> getAllAmiibo() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        final List<dynamic> amiiboListJson = data['amiibo'];
        return amiiboListJson
            .map((json) => AmiiboModel.fromJson(json))
            .toList();
      }
      
      // Jika status code bukan 200
      return [];
    } catch (e) {
      print('API Error: $e');
      // Melemparkan exception dengan pesan yang jelas
      throw Exception('Failed to load Amiibo data: ${e.toString()}'); 
    }
  }
}