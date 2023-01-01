import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  var dailyTemp;
  var condition;
  var date;
  var precip;
  var uvi;

  DailyWeather({
    this.dailyTemp,
    this.condition,
    this.date,
    this.precip,
    this.uvi,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    //converts to JSON
    //virtual constructor factory
    final precipData = json['daily'][0]['pop'];
    final calcPrecip = precipData * 100; //calc of precipitation
    final precipitation = calcPrecip.toStringAsFixed(0); //till 0 decimal places
    return DailyWeather(
      precip: precipitation,
      uvi: json['daily'][0]['uvi'],
    );
  }

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp']['day'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
          isUtc: true), //global time zone
    );
  }

  static DailyWeather fromHourlyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    ); //HourlyWeather
  }
}
