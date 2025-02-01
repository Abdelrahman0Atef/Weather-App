import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/Models/weather_model.dart';

class WeatherServices {
  final Dio dio;
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = 'a3c800378a694d98ab0100423253001';

  WeatherServices(this.dio);

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey%20&q=$cityName&Days=1');
      WeatherModel weatherModel = WeatherModel.fromjson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errMessge = e.response?.data['error']['message'] ??
          'Opps there was an error, please try again later';
      throw Exception(errMessge);
    } catch (e) {
      log(e.toString());
      throw Exception('Opps there was an error, please try again later');
    }
  }
}
