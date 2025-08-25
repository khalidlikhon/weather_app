import 'package:flutter/material.dart';
import 'package:weather_app/models/apiClient.dart';
import 'package:weather_app/models/weather_dataModel.dart';
import 'package:weather_app/widgets/weatherContiner.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController cityController = TextEditingController();

  bool isLoading = false;

  Weather? weather;
  final apiClient _apiClient = apiClient();

  fetchWeather() async {
    final cityName = cityController.text;
    if (cityName.isEmpty) {
      _customSnackBar(context, "Please enter a city name");
      return;
    }

    setState(() => isLoading = true);

    final result = await _apiClient.getWeatherInfo(cityName);
    cityController.clear();
    setState(() {
      weather = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        elevation: 2,
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 53,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // Rounded container
                  color: Colors.grey[200], // Background color for the whole row
                ),
                child: Row(
                  children: [
                    // Search field
                    Expanded(flex: 3, child: _searchCityName()),
                    // Get Weather button
                    Expanded(
                      child: SizedBox(
                        height: 53,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                            backgroundColor: Colors.blue[400], // button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          onPressed: () {
                            fetchWeather();
                          },
                          child: isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Image.asset(
                                  'assets/icons/search.png',
                                  width: 24,
                                  height: 24,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Placeholder for weather info
              Expanded(
                child: Center(
                  child: weather == null
                      ? Text(
                    'Weather info will appear here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  )
                      : WeatherContainer(weather: weather!)


                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Search field widget
  Widget _searchCityName() {
    return TextField(
      controller: cityController,
      decoration: InputDecoration(
        hintText: 'Search city...',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  _customSnackBar(
    BuildContext context,
    String message, {
    Color bgColor = Colors.redAccent,
  }) {
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



  /// Helper widget for details
}
