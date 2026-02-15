import 'package:cocosmartapp/http_client/http_client.dart';
import 'package:flutter/material.dart';
import 'package:google_weather_flutter/google_weather_flutter.dart';

class WeatherProvider extends ChangeNotifier{

  String area_temperature = "0.0";
  String area_humidity = "";
  String rain_percentage = "";
  String soil_moisture = "0.0";

  final weatherService = WeatherService(apiKey: 'AIzaSyAz-ptPgElFO9_ETsI5ne3p7v4Hsgf1x_Q');
  final dioClient = DioClient().dio;


  Future<void> getWeatherData(double lat,double lng) async {
    try {
      final currentConditions = await weatherService.getCurrentConditions(
        lat,
        lng
      );
      area_temperature = '${currentConditions.temperature.degrees}';
      area_humidity = 'HUMIDITY ${currentConditions.relativeHumidity}%';
      rain_percentage = '${currentConditions.precipitation.probability.type} CHANCE ${currentConditions.precipitation.probability.percent}%';

      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getSoilMoistureData(double lat,double lng) async {
    try{
      final queryParams = {
        'lat': lat,
        'lng': lng,
        'params': 'soilMoisture100cm',
        'start': DateTime.now().toUtc(),
        'end': DateTime.now().toUtc(),
      };

      dioClient.options.headers['Authorization'] = 'deaf9206-f3c5-11f0-b72a-0242ac120004-deaf926a-f3c5-11f0-b72a-0242ac120004';

      final response = await dioClient.get(
          'https://api.stormglass.io/v2/bio/point',
          queryParameters:queryParams
      );
      if (response.statusCode == 200) {
        final data = response.data['hours'];
        soil_moisture = data[0]['soilMoisture100cm']['noaa'].toString();
        print(soil_moisture);
        notifyListeners();
      } else {
        print('Failed to load soil moisture data');
      }
    }catch(ex){
      print('Error: $ex');
    }
  }

}