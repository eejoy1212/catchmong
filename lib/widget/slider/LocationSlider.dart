import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class LocationSlider extends StatelessWidget {
  const LocationSlider({super.key, required this.currentValue});
  final double currentValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$currentValue m',
            style: TextStyle(color: CatchmongColors.sub_gray, fontSize: 14),
          ),
          Expanded(
            child: Slider(
              value: currentValue,
              min: 0.0,
              max: 50.0,
              divisions: 10,
              label: '${currentValue.toStringAsFixed(1)} km',
              onChanged: (double value) {},
              thumbColor: Colors.white,
              activeColor: CatchmongColors.yellow_main,
            ),
          ),
          Text(
            '모든지역',
            style: TextStyle(color: CatchmongColors.sub_gray, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
