import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherappbyme/services/weather_model.dart';
import 'package:weatherappbyme/widgets/displayBox.dart';

class Home extends StatefulWidget {
  final List AllLocationWeather;
  final Map currentLocationWeather;

  Home(this.AllLocationWeather, this.currentLocationWeather);

  // const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _timeString = "";
  String currentWeather = '';
  late int temperature;
  String weatherIcon = '';
  String place = '';
  bool _showLoading = false;

  void updateUI(var weather) {
    setState(() {
      if (currentWeather == null) {
        temperature = 0;
        weatherIcon = 'Error';
        place = '';
        currentWeather = 'Unable to get weather data';
        return;
      }
      double temp = weather['main']['temp'];
      temperature = temp.toInt();
      weatherIcon = WeatherModel().getWeatherIcon(temperature);
      currentWeather = weather['weather'][0]['main'];
      place = weather['name'];
      _showLoading = false;
    });
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat('MM dd yyyy \n kk:mm').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    updateUI(widget.currentLocationWeather);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Flutter Weather App"),
      ),
      body: Stack(
        children: [
          Container(
            // color: Colors.blueGrey.shade200,
            width: double.maxFinite,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: width / 5,
                  ),
                  Text(
                    place,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    currentWeather,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      temperature.toString() + "°C",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(weatherIcon),
                  ),
                  Text(
                    _timeString.toString(),
                    style: TextStyle(fontSize: 17, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  _showLoading
                      ? CircularProgressIndicator()
                      : IconButton(
                          visualDensity: VisualDensity.comfortable,
                          splashRadius: 25,
                          splashColor: Colors.white,
                          iconSize: 25,
                          hoverColor: Colors.white,
                          onPressed: () async {
                            setState(() {
                              _showLoading = true;
                            });
                            var weatherData =
                                await WeatherModel().getCurrentWeather();
                            updateUI(weatherData);
                          },
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          )),
                  Expanded(
                    child: SizedBox(
                      height: width / 1,
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: width / 1.8,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.AllLocationWeather.length - 1,
                    itemBuilder: (BuildContext, index) {
                      return displayBox(
                        data: widget.AllLocationWeather[index + 1],
                        time: _timeString.toString(),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
