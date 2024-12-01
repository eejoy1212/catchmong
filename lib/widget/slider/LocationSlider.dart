import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class LocationSlider extends StatelessWidget {
  final double currentValue;
  final void Function(double) onChange;

  const LocationSlider(
      {super.key, required this.currentValue, required this.onChange});
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
              min: 100,
              max: 2000, //임시, 모든지역이 어느정도여야하나,.,?
              divisions: 10,
              label: '${currentValue.toStringAsFixed(1)} km',
              onChanged: onChange,
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
