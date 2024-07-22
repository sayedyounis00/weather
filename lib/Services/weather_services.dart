import 'package:dio/dio.dart';
import 'package:weather/Models/weather_model.dart';

class WeatherServices {
  final dio = Dio();
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '64de6f1b9f174f4bb46125142241107';

  Future<WeatherModel> getWeather() async {
    try {
      final Response respnse = await dio.get(
          '$baseUrl/forecast.json?key=$apiKey&q=cairo&days=1&aqi=no&alerts=no#');
      WeatherModel weatherModel = WeatherModel.fromJson(respnse.data);
      List<String> timesList = [];
      for (var time in respnse.data['forecast']['forecastday'][0]['hour']) {
        timesList.add(time['time']);
        print(respnse.data['forecast']['forecastday'][0]['hour']['time']);
      }
      return weatherModel;
    } on DioException catch (e) {
      final String errMessage =
          e.response?.data['message']['error'] ?? 'try Later...';
      throw Exception(errMessage);
    } catch (e) {
      throw Exception(e);
    }
  }
}
