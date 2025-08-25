import 'package:flutter/material.dart';
import '../models/weather_dataModel.dart';

class WeatherContainer extends StatelessWidget {
  final Weather weather;

  const WeatherContainer({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isDay = weather.isDay == 1;
    final gradientColors = isDay
        ? [Colors.lightBlue.shade300, Colors.blue.shade100] // soft sky blue
        : [Colors.indigo.shade900, Colors.deepPurple.shade700]; // night sky

    final textPrimary = isDay ? Colors.blueGrey.shade900 : Colors.white;
    final textSecondary = isDay ? Colors.blueGrey.shade700 : Colors.white70;
    final detailTitleColor = isDay ? Colors.blueGrey.shade800 : Colors.white70;
    final detailValueColor = isDay ? Colors.grey.shade700 : Colors.grey.shade400;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Weather Data Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Location & Local Time
                  Text(
                    "${weather.name}, ${weather.country}",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Local Time: ${weather.localtime}",
                    style: TextStyle(
                      fontSize: 14,
                      color: textSecondary,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Weather Icon
                  Image.network(
                    weather.iconHttps,
                    width: 90,
                    height: 90,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.cloud, size: 90, color: Colors.grey.shade400),
                  ),
                  SizedBox(height: 14),

                  // Condition & Temperature
                  Text(
                    weather.conditionText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                  SizedBox(height: 18),

                  // Temperature Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${weather.tempC}°C",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "/",
                        style: TextStyle(fontSize: 20, color: textSecondary),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${weather.tempF}°F",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Feels like: ${weather.feelslikeC}°C",
                    style: TextStyle(
                      fontSize: 14,
                      color: textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Essential Details Grid
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 26,
                    runSpacing: 18,
                    children: [
                      _DetailColumn(
                          icon: Icons.air,
                          title: "Wind",
                          value: "${weather.windKph} km/h ${weather.windDir}",
                          titleColor: detailTitleColor,
                          valueColor: detailValueColor),
                      _DetailColumn(
                          icon: Icons.cloud,
                          title: "Cloud",
                          value: "${weather.cloud}%",
                          titleColor: detailTitleColor,
                          valueColor: detailValueColor),
                      _DetailColumn(
                          icon: Icons.opacity,
                          title: "Humidity",
                          value: "${weather.humidity}%",
                          titleColor: detailTitleColor,
                          valueColor: detailValueColor),
                      _DetailColumn(
                          icon: Icons.speed,
                          title: "Pressure",
                          value: "${weather.pressureMb} mb",
                          titleColor: detailTitleColor,
                          valueColor: detailValueColor),
                      _DetailColumn(
                          icon: Icons.grain,
                          title: "Precipitation",
                          value: "${weather.precipMm} mm",
                          titleColor: detailTitleColor,
                          valueColor: detailValueColor),
                      _DetailColumn(
                          icon: Icons.remove_red_eye,
                          title: "Visibility",
                          value: "${weather.visKm} km",
                          titleColor: detailTitleColor,
                          valueColor: detailValueColor),
                      _DetailColumn(
                          icon: Icons.wb_sunny,
                          title: "UV",
                          value: "${weather.uv}",
                          titleColor: detailTitleColor,
                          valueColor: detailValueColor),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 14),

            // Last Updated outside the card
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  "Last updated: ${weather.lastUpdated}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _DetailColumn({
    required IconData icon,
    required String title,
    required String value,
    required Color titleColor,
    required Color valueColor,
  }) {
    return Column(
      children: [
        Icon(icon, size: 22, color: titleColor),
        SizedBox(height: 4),
        Text(title,
            style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                letterSpacing: 0.3)),
        Text(value,
            style: TextStyle(fontSize: 12, color: valueColor, height: 1.2)),
      ],
    );
  }
}
