// import 'dart:html';

import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  var data;
  double longitude = 35;
  double latitude = 35;
  double temprature = 0;

  void getLocation() async {
    // await Geolocator.openLocationSettings();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    longitude = position.longitude;
    latitude = position.latitude;
    getData();
    // print(position);
  }

  void getData() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=8c17407bb21260c7ce00ef364652df99'));
    var weatherdata = response.body;
    data = jsonDecode(weatherdata);
    setState(() {
      temprature = data['main']['temp'];
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // body: SpinKitChasingDots(
        //   color: Colors.orangeAccent,
        //   duration: Duration(seconds: 2),
        // ),
        );
  }
}
