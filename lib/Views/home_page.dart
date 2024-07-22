import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/Models/weather_model.dart';
import 'package:weather/Services/weather_services.dart';
import 'package:weather/Widgets/custom_weather_card.dart';
import '../Widgets/custom_data.dart';
import '../Widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final WeatherServices weatherServices;
  late Future<WeatherModel> future;
  String city = "London"; // Default city

  @override
  void initState() {
    super.initState();
    weatherServices = WeatherServices();
    future = weatherServices.getWeather(city: city);
  }

  void _updateWeather() {
    setState(() {
      future = weatherServices.getWeather(city: city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(),
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Search For Your City'),
                      content: SingleChildScrollView(
                        child: TextField(
                          onSubmitted: (value) {
                            setState(() {
                              city = value;
                              _updateWeather();
                              Navigator.of(context).pop();
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Search'),
                          onPressed: () {
                            _updateWeather();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<WeatherModel>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 300.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: snapshot.data!.country,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/cloudy.png',
                        cacheHeight: 250,
                      ),
                      CustomText(
                        text: snapshot.data!.condition,
                        fontSize: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomData(
                            value: ' ${snapshot.data!.temp.round()}',
                            image: 'assets/wind.png',
                            unit: 'mph',
                            about: 'Wind',
                          ),
                          CustomData(
                            value: ' ${snapshot.data!.temp.round()}°',
                            image: 'assets/celsius.png',
                            about: 'Temperature',
                          ),
                          CustomData(
                            value: '${snapshot.data!.humidity}%',
                            image: 'assets/water-drops.png',
                            about: 'humidity',
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Today',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.timeList.length,
                          itemBuilder: (context, index) {
                            return CustomWeatherCard(
                              time: snapshot.data!.timeList[index],
                              temp: snapshot.data!.tempList![index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Text('Has Error: ${snapshot.error}');
              }
            },
          ),
        ),
      ),
    );
  }
}
