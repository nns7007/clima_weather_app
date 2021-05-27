

import 'location.dart';
import 'networking.dart';

const openurl='https://api.openweathermap.org/data/2.5/weather';
const apikey='e72ca729af228beabd5d20e3b7749713';
class WeatherModel {
  Future<dynamic> getweatherdata()async{
    double latitude;
    double longitude;
    Location location=Location();
    await location.getcurrentlocation();
    latitude=location.latitude;
    longitude=location.longitude;

    NetworkHelper networkHelper= NetworkHelper('$openurl?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    var weatherdata=await networkHelper.getData();
    return weatherdata;
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

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
