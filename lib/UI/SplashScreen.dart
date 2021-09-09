import 'package:flutter/material.dart';
import 'package:weatherappbyme/UI/Home.dart';
import 'package:weatherappbyme/services/weather_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Map weatherData = await WeatherModel().getLocationWeather();
    Map currentWeatherData = await WeatherModel().getCurrentWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      print(currentWeatherData['main']['temp']);
      return Home(weatherData['list'], currentWeatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Text(
          "Weather App",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
