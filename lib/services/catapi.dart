import 'dart:convert';

import '../models/breed.dart';
import '../models/image.dart';
import 'package:http/http.dart' as http;

class StatusErrorException implements Exception {
  final String message;

  StatusErrorException(this.message);

  @override
  String toString() {
    return "StatusErrorException: $message";
  }
}

class CatApi {
  static const String baseUrl = 'https://api.thecatapi.com/v1';
  static const String apiKey = 'live_OuHvDxavqFkLb68B2iVUFPtwqLQXwiktv50RKQ3KjkD2hXKNTg41EFK4JOIanZwr';

  static Future<List<Breed>> getBreeds() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/breeds"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-api-key': apiKey,

        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> breedsJson = jsonDecode(response.body);
        return breedsJson.map((json) => Breed.fromJson(json)).toList();
      } else {
        throw StatusErrorException('Failed to load breeds: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw StatusErrorException('Error occurred while fetching breeds: $e');
    }
  }

  Future<Image> getImage(String breedId) async {
    try {
      // Construct the full URL using breedId and limit parameters
      final response = await http.get(
        Uri.parse("$baseUrl/images/search?breed_id=$breedId&limit=1"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
      ).timeout(const Duration(seconds: 10));

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          // Return the first image from the response list
          return Image.fromJson(data[0]);
        } else {
          throw StatusErrorException('No images found for breed ID: $breedId');
        }
      } else {
        throw StatusErrorException('Failed to load image: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      // Catch and throw any errors that occur during the request
      throw StatusErrorException('Error occurred while fetching image: $e');
    }
  }


  Future<List<Image>> getImages(String breedId, int limit) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/images/search?breed_id=$breedId&limit=$limit"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          // Map the response list to a list of Image objects
          return data.map((json) => Image.fromJson(json)).toList();
        } else {
          throw StatusErrorException('No images found for breed ID: $breedId');
        }
      } else {
        throw StatusErrorException('Failed to load images: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw StatusErrorException('Error occurred while fetching images: $e');
    }
  }

}