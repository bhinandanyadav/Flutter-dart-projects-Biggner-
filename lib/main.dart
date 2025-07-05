import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 1, 3, 5),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Poppins',
      ),
      themeMode: ThemeMode.system,
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;
  String _errorMessage = '';
  final String _apiKey = '39df7078af843ab2a02ce39f1a9f4d1a';

  @override
  void initState() {
    super.initState();
    // Optional: Get user's location automatically
    // _getCurrentLocation();
  }

  Future<void> _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'City not there in this world';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching weather data';
        _isLoading = false;
      });
    }
  }

  String _getBackgroundImage(String? condition) {
    if (condition == null) return 'lib/assets/images/default.jpg';

    switch (condition.toLowerCase()) {
      case 'clear':
        return 'lib/assets/images/clear.jpg';
      case 'clouds':
        return 'lib/assets/images/cloudy.jpg';
      case 'rain':
      case 'drizzle':
        return 'lib/assets/images/rainy.jpg';
      case 'thunderstorm':
        return 'lib/assets/images/stromy.jpg';
      case 'snow':
        return 'lib/assets/images/snow.jpg';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/images/foggy.jpg';
      default:
        return 'lib/assets/images/default.jpg';
    }
  }

  Widget _buildWeatherIcon(String condition) {
    final double iconSize = 80;
    final Color iconColor = const Color.fromARGB(255, 170, 235, 5);

    switch (condition.toLowerCase()) {
      case 'clear':
        return Icon(Icons.wb_sunny_rounded, size: iconSize, color: iconColor);
      case 'clouds':
        return Icon(Icons.cloud_rounded, size: iconSize, color: iconColor);
      case 'rain':
      case 'drizzle':
        return Icon(Icons.grain_rounded, size: iconSize, color: iconColor);
      case 'thunderstorm':
        return Icon(Icons.flash_on_rounded, size: iconSize, color: iconColor);
      case 'snow':
        return Icon(Icons.ac_unit_rounded, size: iconSize, color: iconColor);
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return Icon(
          Icons.cloud_queue_rounded,
          size: iconSize,
          color: iconColor,
        );
      default:
        return Icon(Icons.cloud_rounded, size: iconSize, color: iconColor);
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // ignore: deprecated_member_use
        backgroundColor: const Color.fromARGB(60, 53, 30, 30).withOpacity(0.9),
        title: const Text('City Dhund Lo...'),
        content: TextField(
          controller: _cityController,
          decoration: InputDecoration(
            hintText: 'Naam Dal Jaldi...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            filled: true,
            fillColor: const Color.fromARGB(0, 14, 4, 4),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              Navigator.pop(context);
              _fetchWeather(value);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Choro...'),
          ),
          FilledButton(
            onPressed: () {
              if (_cityController.text.isNotEmpty) {
                Navigator.pop(context);
                _fetchWeather(_cityController.text);
              }
            },
            child: const Text('Dhund Do...'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(247, 91, 65, 65),
        elevation: 0,
        title: const Text(
          'Weather Bata Du...!',
          style: TextStyle(
            color: Color.fromARGB(255, 249, 249, 250),
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              _weatherData != null
                  ? _getBackgroundImage(_weatherData!['weather'][0]['main'])
                  : 'lib/assets/images/default.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.3),
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
            child: SafeArea(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            if (_errorMessage.isNotEmpty) ...[
                              const SizedBox(height: 30),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      _errorMessage,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            if (_weatherData != null) ...[
                              const SizedBox(height: 30),
                              // City name with animation
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 500),
                                builder: (context, value, child) {
                                  return Opacity(opacity: value, child: child);
                                },
                                child: Text(
                                  _weatherData!['name'],
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Date and time
                              Text(
                                _getFormattedDate(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Weather icon
                              _buildWeatherIcon(
                                _weatherData!['weather'][0]['main'],
                              ),
                              const SizedBox(height: 20),
                              // Temperature
                              TweenAnimationBuilder<double>(
                                tween: Tween(
                                  begin: 0.0,
                                  end: _weatherData!['main']['temp'],
                                ),
                                duration: const Duration(milliseconds: 800),
                                builder: (context, value, child) {
                                  return Text(
                                    '${value.toStringAsFixed(1)}°C',
                                    style: const TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                              // Weather description
                              Text(
                                _weatherData!['weather'][0]['description']
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 5),
                              // Feels like temperature
                              Text(
                                'Feels like: ${_weatherData!['main']['feels_like'].toStringAsFixed(1)}°C',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Weather details card
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _weatherDetailItem(
                                              Icons.water_drop_rounded,
                                              'Humidity',
                                              '${_weatherData!['main']['humidity']}%',
                                            ),
                                            _weatherDetailItem(
                                              Icons.air_rounded,
                                              'Wind Speed',
                                              '${_weatherData!['wind']['speed']} m/s',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _weatherDetailItem(
                                              Icons.compress_rounded,
                                              'Pressure',
                                              '${_weatherData!['main']['pressure']} hPa',
                                            ),
                                            _weatherDetailItem(
                                              Icons.visibility_rounded,
                                              'Visibility',
                                              '${(_weatherData!['visibility'] / 1000).toStringAsFixed(1)} km',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ] else if (!_isLoading &&
                                _errorMessage.isEmpty) ...[
                              const SizedBox(height: 100),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.search,
                                          size: 80,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Search for a city',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Enter a city name to get the current weather information',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            // ignore: deprecated_member_use
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        FilledButton.icon(
                                          onPressed: _showSearchDialog,
                                          icon: const Icon(Icons.search),
                                          label: const Text('Search Now'),
                                          style: FilledButton.styleFrom(
                                            backgroundColor: Colors.white
                                                // ignore: deprecated_member_use
                                                .withOpacity(0.3),
                                            foregroundColor:
                                                const Color.fromARGB(
                                                  255,
                                                  211,
                                                  9,
                                                  9,
                                                ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
      // Floating action button for refreshing or getting current location
      floatingActionButton: _weatherData != null
          ? FloatingActionButton(
              onPressed: () => _fetchWeather(_weatherData!['name']),
              backgroundColor: Colors.white.withOpacity(0.3),
              child: const Icon(Icons.refresh, color: Colors.white),
            )
          : null,
    );
  }

  Widget _weatherDetailItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getFormattedDate() {
    DateTime now = DateTime.now();
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    String period = now.hour >= 12 ? 'PM' : 'AM';
    int hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);

    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}, ${now.year} | $hour:${now.minute.toString().padLeft(2, '0')} $period';
  }
}
