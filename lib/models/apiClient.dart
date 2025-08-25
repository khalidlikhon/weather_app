import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_dataModel.dart';

class apiClient {

  final String _baseUrl = 'https://api.weatherapi.com/v1/current.json';
  final String _apiKey = '291e2d051e624ed488974910240410';

  Future<Weather?> getWeatherInfo(String cityName) async {
    try {
      final url = '$_baseUrl?key=$_apiKey&q=$cityName';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Weather.fromJson(data);
      } else {
        print('API Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching weather: $e');
      return null;
    }
  }
}