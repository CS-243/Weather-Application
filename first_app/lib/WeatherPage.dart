/*import 'package:first_app/SecondPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final String apiKey =
      'e43e63775ebea9d844b0bb510d83f4b5'; // Replace with your actual API key
  final List<String> cities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Kolkata',
    'Chennai',
    // Add more cities as desired
  ];

  List<WeatherData> weatherDataList = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    for (String city in cities) {
      final weatherData = await fetchWeather(apiKey, city);
      setState(() {
        weatherDataList.add(weatherData);
      });
    }
  }

  Future<WeatherData> fetchWeather(String apiKey, String city) async {
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      return WeatherData.fromJson(decodedData);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: Colors.black,
        
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
              icon: const Icon(Icons.arrow_back)),

                   
      ),
      body: ListView.builder(
        itemCount: weatherDataList.length,
        itemBuilder: (context, index) {
          final weatherData = weatherDataList[index];
          return ListTile(
            title: Text(weatherData.cityName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Temperature: ${weatherData.temperature}°C'),
                Text('Description: ${weatherData.description}'),
              ],
            ),
          );
        },
      ),

      
    );
  }
}

class WeatherData {
  final String cityName;
  final double temperature;
  final String description;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      temperature: (json['main']['temp'] - 273.15),
      description: json['weather'][0]['description'],
    );
  }
}
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.blueGrey[900], 
        ),
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  final String apiKey = '58e2c5e565c74d21bdd105406231207'; 
  final List<String> cities = ['Kolkata','Mumbai', 'Delhi', 'Bangalore', 'Chennai']; 
  List<WeatherData> weatherDataList = [];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  WeatherData? selectedWeatherData;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    fetchWeatherData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchWeatherData() async {
    for (String city in cities) {
      final url = Uri.parse(
          'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=4');

      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final weatherData = WeatherData.fromJson(jsonDecode(response.body));
          setState(() {
            weatherDataList.add(weatherData);
          });
          _controller.forward();
        } else {
          print('Failed to fetch weather data for $city');
          print('Response status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error fetching weather data for $city: $e');
      }
    }
  }

  void _onWeatherCardTap(WeatherData weatherData) {
    setState(() {
      selectedWeatherData = weatherData;
    });
  }

  Widget _buildSelectedWeatherCard() {
    if (selectedWeatherData == null) {
      return Container();
    }

    final weatherCondition = selectedWeatherData!.weatherCondition;
    IconData weatherIcon;
    switch (weatherCondition) {
      case WeatherCondition.clear:
        weatherIcon = Icons.wb_sunny;
        break;
      case WeatherCondition.cloudy:
        weatherIcon = Icons.wb_cloudy;
        break;
      case WeatherCondition.rainy:
        weatherIcon = Icons.beach_access;
        break;
      case WeatherCondition.snowy:
        weatherIcon = Icons.ac_unit;
        break;
      default:
        weatherIcon = Icons.help;
    }

    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedWeatherData = null;
          });
        },
        child: Container(
          color: Colors.black.withOpacity(0.6),
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.center,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      weatherIcon,
                      size: 50,
                    ),
                    SizedBox(height: 16),
                    Text(
                      selectedWeatherData!.city,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      selectedWeatherData!.description,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${selectedWeatherData!.temperature.toStringAsFixed(1)}°C',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Weather Forecast:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    for (WeatherForecast forecast in selectedWeatherData!.forecasts)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            forecast.date,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${forecast.minTemp.toStringAsFixed(1)}°C - ${forecast.maxTemp.toStringAsFixed(1)}°C',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: weatherDataList.length,
            itemBuilder: (context, index) {
              final weatherData = weatherDataList[index];
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Card(
                  child: ListTile(
                    leading: _buildWeatherIcon(weatherData.weatherCondition),
                    title: Text(
                      weatherData.city,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      weatherData.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      '${weatherData.temperature.toStringAsFixed(1)}°C',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () => _onWeatherCardTap(weatherData),
                  ),
                ),
              );
            },
          ),
          if (selectedWeatherData != null) _buildSelectedWeatherCard(),
        ],
      ),
    );
  }

  Widget _buildWeatherIcon(WeatherCondition weatherCondition) {
    IconData iconData;
    switch (weatherCondition) {
      case WeatherCondition.clear:
        iconData = Icons.wb_sunny;
        break;
      case WeatherCondition.cloudy:
        iconData = Icons.wb_cloudy;
        break;
      case WeatherCondition.rainy:
        iconData = Icons.beach_access;
        break;
      case WeatherCondition.snowy:
        iconData = Icons.ac_unit;
        break;
      default:
        iconData = Icons.help;
    }
    return Icon(iconData);
  }
}

enum WeatherCondition {
  clear,
  cloudy,
  rainy,
  snowy,
}

class WeatherData {
  final String city;
  final String description;
  final double temperature;
  final WeatherCondition weatherCondition;
  final List<WeatherForecast> forecasts;

  WeatherData({
    required this.city,
    required this.description,
    required this.temperature,
    required this.weatherCondition,
    required this.forecasts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final weatherConditionText = json['current']['condition']['text'].toLowerCase();
    WeatherCondition weatherCondition;
    if (weatherConditionText.contains('clear')) {
      weatherCondition = WeatherCondition.clear;
    } else if (weatherConditionText.contains('cloud')) {
      weatherCondition = WeatherCondition.cloudy;
    } else if (weatherConditionText.contains('rain')) {
      weatherCondition = WeatherCondition.rainy;
    } else if (weatherConditionText.contains('snow')) {
      weatherCondition = WeatherCondition.snowy;
    } else {
      weatherCondition = WeatherCondition.clear;
    }

    final List<WeatherForecast> forecasts = [];
    final forecastData = json['forecast']['forecastday'] as List<dynamic>;
    for (var data in forecastData) {
      final date = data['date'];
      final minTemp = data['day']['mintemp_c'];
      final maxTemp = data['day']['maxtemp_c'];
      forecasts.add(WeatherForecast(date: date, minTemp: minTemp, maxTemp: maxTemp));
    }

    return WeatherData(
      city: json['location']['name'],
      description: json['current']['condition']['text'],
      temperature: json['current']['temp_c'],
      weatherCondition: weatherCondition,
      forecasts: forecasts,
    );
  }
}

class WeatherForecast {
  final String date;
  final double minTemp;
  final double maxTemp;

  WeatherForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
  });
}

