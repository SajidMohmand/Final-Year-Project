import 'package:flutter/material.dart';
import '../models/slider_model.dart';

class SliderWidget extends StatelessWidget {
  final SliderModel slide;

  SliderWidget(this.slide);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(slide.imagePath, width: 300, height: 300),
        SizedBox(height: 20),
        Text(
          slide.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            slide.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
