import 'package:intl/intl.dart';

class WeatherModel {
  final String country;
  final double wind;
  final double temp;
  final int humidity;
  final String condition;
  final List timeList;
  final List tempList;

  WeatherModel( 
      {required this.country,
      required this.timeList,
      required this.wind,
      required this.temp,
      required this.humidity,
      required this.condition,
       required this.tempList,
      });

  factory WeatherModel.fromJson(json) {
    List timesList = [];
    for (Map time in json['forecast']['forecastday'][0]['hour']) {   
       String formatTime=DateFormat('hh:mm').format(DateTime.parse(time['time']));
      timesList.add(formatTime);
    }
    List tempList = [];
    for (Map temp in json['forecast']['forecastday'][0]['hour']) {   
      tempList.add(temp['temp_c']);
    }
    return WeatherModel(
      country: json['location']['name'],
      wind: json['current']['wind_mph'],
      temp: json['current']['temp_c'],
      humidity: json['current']['humidity'],
      condition: json['current']['condition']['text'],
      timeList: timesList, 
      tempList: tempList,
    );
  }
}
