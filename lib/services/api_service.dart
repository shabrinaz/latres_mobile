import 'dart:convert'; 
import 'package:http/http.dart' as http; 
import '../models/amiibo_model.dart';

class ApiService {
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
      
      return [];
    } catch (e) {
      print('API Error: $e');
      throw Exception('Gagal mengambil data : ${e.toString()}'); 
    }
  }
}