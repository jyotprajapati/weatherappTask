import 'package:flutter/material.dart';
import 'package:weatherappbyme/services/weather_model.dart';

class displayBox extends StatefulWidget {
  final Map data;
  final String time;
  displayBox({required this.data, required this.time});

  @override
  _displayBoxState createState() => _displayBoxState();
}

class _displayBoxState extends State<displayBox> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        width: width / 3.1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.data['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  widget.data['weather'][0]['main'],
                  style: TextStyle(fontSize: 22),
                ),
                Center(
                  child: Text(
                    widget.data['main']['temp'].toInt().toString() + "°C",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Center(
                  child: Text(WeatherModel()
                      .getWeatherIcon(widget.data['main']['temp'].toInt())),
                ),
                Text(
                  widget.time,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
