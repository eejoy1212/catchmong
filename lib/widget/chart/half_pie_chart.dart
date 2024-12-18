import 'package:catchmong/const/catchmong_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HalfPieChart extends StatelessWidget {
  const HalfPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0, //-math.pi / 2,
      child: PieChart(
        PieChartData(
          startDegreeOffset: 180,
          sectionsSpace: 0,
          centerSpaceRadius: 50,
          sections: [
            PieChartSectionData(
              value: 30,
              color: CatchmongColors.blue2,
              showTitle: false,
              radius: 60,
            ),
            PieChartSectionData(
              value: 20,
              color: Color(0xFFF98585),
              showTitle: false,
              radius: 60,
            ),

            //가리는 용도
            PieChartSectionData(
              value: 50,
              color: Colors.transparent,
              showTitle: false,
              radius: 60,
            ),
          ],
        ),
      ),
    );
  }
}
