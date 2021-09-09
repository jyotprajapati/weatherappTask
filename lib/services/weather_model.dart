import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

const kApiKey = 'e486ccbc2801417e5d8f786f5656140b';
const kApiMapUrl = 'https://api.openweathermap.org/data/2.5/find';
const cnt = 20;

class WeatherModel {
  double latitude = 0.0;
  double longitude = 0.0;

  Future getData(String urls) async {
    var url = Uri.parse(urls);
    var response = await http.post(url, body: {});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      print("lat ");
      print(latitude);
      print("lon = ");
      print(longitude);
    } catch (e) {
      print("long and lat not found");
      print(e);
    }
  }

  Future<dynamic> getLocationWeather() async {
    await getCurrentLocation();
    var weatherData = await getData(
        '$kApiMapUrl?lat=${latitude}&lon=${longitude}&cnt=$cnt&appid=$kApiKey&units=metric');
    print("returning weather data");
    return weatherData;
  }

  Future<dynamic> getCurrentWeather() async {
    await getCurrentLocation();
    var currentWeather = await getData(
        'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$kApiKey&units=metric');
    print("returning current weather data");
    return currentWeather;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
