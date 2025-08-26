
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/apiClient.dart';
import '../../models/weather_dataModel.dart';


class WeatherController extends GetxController {
  final cityController = TextEditingController();

  final isLoading = false.obs;
  final weather = Rxn<Weather>(); // nullable Rx<Weather>
  final _apiClient = apiClient();

  void fetchWeather(BuildContext context) async {
    final cityName = cityController.text;
    if (cityName.isEmpty) {
      _customSnackBar(context, "Please enter a city name");
      return;
    }

    isLoading.value = true;

    final result = await _apiClient.getWeatherInfo(cityName);
    cityController.clear();

    weather.value = result;
    isLoading.value = false;
  }

  void _customSnackBar(BuildContext context, String message,
      {Color bgColor = Colors.redAccent}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.all(15),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
