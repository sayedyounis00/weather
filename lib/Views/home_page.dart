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
  late final Future<WeatherModel> future;

  @override
  void initState() {
    super.initState();
    weatherServices = WeatherServices();
    future = weatherServices.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ))
          ],
        ),
        body: FutureBuilder<WeatherModel>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 300.0),
                  child: CircularProgressIndicator(),
                ));
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
                              return  CustomWeatherCard(time:snapshot.data!.timeList[index],);
                            }),
                      ),
                    ],
                  ),
                );
              } else  {
                return Text('Has Error:${snapshot.error}');
              }
            }));
  }
}
