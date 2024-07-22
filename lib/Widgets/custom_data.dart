import 'package:flutter/material.dart';
import 'package:weather/Widgets/custom_text.dart';

class CustomData extends StatelessWidget {
  const CustomData({
    super.key, required this.value, required this.image,  this.unit, required this.about, this.cacheHeight,
  });
  final String value;
  final String image;
  final String? unit;
  final String about;
  final int? cacheHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          cacheHeight: 40,
        ),
         Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            CustomText(
              text: value,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              text: unit??'',
              fontSize: 15,
            ),
          ],
        ),
         CustomText(
          text: about,
          fontSize: 15,
        )
      ],
    );
  }
}
