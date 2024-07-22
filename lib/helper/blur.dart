
import 'dart:ui';

import 'package:flutter/material.dart';

class GaussianBlurImage extends StatelessWidget {
  final Image image;
  final double sigma;

  GaussianBlurImage({
    required this.image,
    this.sigma = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: image,
      ),
    );
  }
}