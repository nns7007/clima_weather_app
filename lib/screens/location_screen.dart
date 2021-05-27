
import 'package:clima_weather_app/services/weather.dart';
import 'package:clima_weather_app/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'city_screen.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=WeatherModel();
  int tempdata;
  String weathericon;
  String Cityname;
  String weathermsg;

  @override
  void initState(){
    super.initState();
    updateUI(widget.locationweather);
  }
  void updateUI(dynamic weatherdata){
    if(weatherdata==null){
      tempdata=0;
      weathericon='Error';
      weathermsg='unable to get data';
      Cityname='';
      return;
    }
    double temp=weatherdata['main']['temp'];
    tempdata=temp.toInt();
    var cont=weatherdata['weather'][0]['id'];
    weathericon=weather.getWeatherIcon(cont);
    weathermsg=weather.getMessage(tempdata);
    Cityname=weatherdata['name'];
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherdata=await weather.getweatherdata();
                      updateUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },),);
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempdata°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weathermsg in $Cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
