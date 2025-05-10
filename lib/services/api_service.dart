import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL untuk API Anda
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Fungsi untuk melakukan GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url);

    // Memeriksa apakah response berhasil
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Fungsi untuk melakukan POST request
  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(url,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  // Fungsi untuk melakukan PUT request
  Future<Map<String, dynamic>> put(
      String endpoint, Map<String, dynamic> body) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final response = await http.put(url,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update data');
    }
  }

  // Fungsi untuk melakukan DELETE request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }
}
