class Weather {
  // Core fields for UI
  final String name;          // City name
  final String country;       // Country
  final String localtime;     // Local time string
  final double tempC;         // Temperature in Celsius
  final double tempF;         // Temperature in Fahrenheit
  final String conditionText; // Condition text (Cloudy, Sunny etc.)
  final String conditionIcon; // Icon URL (needs https:)
  final double windKph;       // Wind speed
  final String windDir;       // Wind direction (e.g., S, NNW)
  final int cloud;            // Cloud percentage
  final int humidity;         // Humidity %
  final double feelslikeC;    // Feels like Celsius
  final double pressureMb;    // Pressure in mb
  final double precipMm;      // Precipitation mm
  final double visKm;         // Visibility km
  final double uv;            // UV index
  final int isDay;            // 1 = day, 0 = night
  final String lastUpdated;   // Last updated string

  Weather({
    required this.name,
    required this.country,
    required this.localtime,
    required this.tempC,
    required this.tempF,
    required this.conditionText,
    required this.conditionIcon,
    required this.windKph,
    required this.windDir,
    required this.cloud,
    required this.humidity,
    required this.feelslikeC,
    required this.pressureMb,
    required this.precipMm,
    required this.visKm,
    required this.uv,
    required this.isDay,
    required this.lastUpdated,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['location']['name'] ?? '',
      country: json['location']['country'] ?? '',
      localtime: json['location']['localtime'] ?? '',
      tempC: (json['current']['temp_c'] ?? 0).toDouble(),
      tempF: (json['current']['temp_f'] ?? 0).toDouble(),
      conditionText: json['current']['condition']['text'] ?? '',
      conditionIcon: json['current']['condition']['icon'] ?? '',
      windKph: (json['current']['wind_kph'] ?? 0).toDouble(),
      windDir: json['current']['wind_dir'] ?? '',
      cloud: (json['current']['cloud'] ?? 0).toInt(),
      humidity: (json['current']['humidity'] ?? 0).toInt(),
      feelslikeC: (json['current']['feelslike_c'] ?? 0).toDouble(),
      pressureMb: (json['current']['pressure_mb'] ?? 0).toDouble(),
      precipMm: (json['current']['precip_mm'] ?? 0).toDouble(),
      visKm: (json['current']['vis_km'] ?? 0).toDouble(),
      uv: (json['current']['uv'] ?? 0).toDouble(),
      isDay: (json['current']['is_day'] ?? 0).toInt(),
      lastUpdated: json['current']['last_updated'] ?? '',
    );
  }

  /// Helper for icon URL
  String get iconHttps => conditionIcon.startsWith('http')
      ? conditionIcon
      : 'https:$conditionIcon';
}
