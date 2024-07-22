import 'package:flutter/material.dart';
import 'package:weather/Widgets/custom_text.dart';

class CustomWeatherCard extends StatelessWidget {
  const CustomWeatherCard({
   super.key,   required this.time,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 10),
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      height: 190,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
            CustomText(
            text: time,
            fontSize: 20,
          ),
          Image.asset(
            'assets/cloudy.png',
            cacheHeight: 70,
          ),
          const CustomText(
            text: '28°',
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
