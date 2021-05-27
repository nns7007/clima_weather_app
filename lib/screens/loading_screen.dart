import 'package:clima_weather_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationdata();
  }
  void getLocationdata() async {
   // WeatherModel weatherModel=WeatherModel();

    var weatherdata=await WeatherModel().getweatherdata();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweather: weatherdata,);
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
