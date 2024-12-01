import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class LocationSlider extends StatelessWidget {
  final double currentValue;
  final void Function(double) onChange;
  final void Function(double) onChangeEnd;

  const LocationSlider({
    super.key,
    required this.currentValue,
    required this.onChange,
    required this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${currentValue.toInt()} m', // 정수로 출력
            style: TextStyle(color: CatchmongColors.sub_gray, fontSize: 14),
          ),
          Expanded(
            child: Slider(
              value: currentValue,
              min: 100,
              max: 100000,
              divisions: 99900, // 최소값과 최대값 사이를 1m 단위로 나눔
              label: '${currentValue.toInt()} m', // 슬라이더의 레이블도 정수로 표시
              onChanged: onChange,
              onChangeEnd: onChangeEnd,
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
