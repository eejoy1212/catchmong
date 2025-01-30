import 'package:catchmong/const/catchmong_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HalfPieChart extends StatelessWidget {
  final double value1; // 첫 번째 값
  final double value2; // 두 번째 값
  final Color color1; // 첫 번째 값 색상
  final Color color2; // 두 번째 값 색상

  const HalfPieChart({
    Key? key,
    required this.value1,
    required this.value2,
    this.color1 = CatchmongColors.blue2,
    this.color2 = const Color(0xFFF98585),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0, // -math.pi / 2,  // 필요 시 추가
      child: PieChart(
        PieChartData(
          startDegreeOffset: 180, // 반원으로 시작하는 위치
          sectionsSpace: 0, // 섹션 간 간격
          centerSpaceRadius: 50, // 가운데 빈 공간
          sections: [
            PieChartSectionData(
              value: value1 / 2,
              color: color1,
              showTitle: false,
              radius: 60,
            ),
            PieChartSectionData(
              value: value2 / 2,
              color: color2,
              showTitle: false,
              radius: 60,
            ),
            // 나머지 반원을 가리는 용도
            PieChartSectionData(
              value: 100 - (value1 / 2 + value2 / 2),
              color: Colors.transparent, // 투명한 색상
              showTitle: false,
              radius: 60,
            ),
          ],
        ),
      ),
    );
  }
}
