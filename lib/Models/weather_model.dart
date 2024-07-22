class WeatherModel {
  final String country;
  final double wind;
  final double temp;
  final int humidity;
  final String condition;
  final List timeList;

  WeatherModel(
      {required this.country,
      required this.timeList,
      required this.wind,
      required this.temp,
      required this.humidity,
      required this.condition});

  factory WeatherModel.fromJson(json) {
    List timesList = [];
    for (var time in json['forecast']['forecastday'][0]['hour']) {
      timesList.add(time['time']);
    }
    return WeatherModel(
      country: json['location']['name'],
      wind: json['current']['wind_mph'],
      temp: json['current']['temp_c'],
      humidity: json['current']['humidity'],
      condition: json['current']['condition']['text'],
      timeList: timesList,
    );
  }
}
