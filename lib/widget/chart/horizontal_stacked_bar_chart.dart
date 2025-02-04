import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class HorizontalStackedBarChart extends StatelessWidget {
  final List<List<int>> data;
  final List<String> labels;
  final List<Color> colors;

  HorizontalStackedBarChart({
    Key? key,
    required this.data,
    required this.labels,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(data.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  labels[index],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: CatchmongColors.gray400,
                  ),
                ),
              ),
              SizedBox(width: 8),
              // CustomPaint가 제대로 보이도록 높이(height) 지정
              SizedBox(
                width: width - 170,
                height: 20, // CustomPaint가 보이도록 명시적인 높이 지정
                child: CustomPaint(
                  size: Size(width - 170, 20),
                  painter: _StackedBarPainter(data[index], colors),
                ),
              ),
              SizedBox(width: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(data[index].length, (int i) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "${data[index][i]}%",
                      style: TextStyle(
                        color: colors[i],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _StackedBarPainter extends CustomPainter {
  final List<int> values;
  final List<Color> colors;

  _StackedBarPainter(this.values, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final total = values.isNotEmpty ? values.reduce((a, b) => a + b) : 0;

    // total이 0일 경우 아무것도 그리지 않음
    if (total == 0) return;

    // 배경 색상 먼저 그리기
    paint.color = Colors.grey[300]!;
    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(4), // 더 부드러운 둥근 모서리
    );
    canvas.drawRRect(backgroundRect, paint);

    // 스택 막대 그리기
    double startX = 0;
    for (int i = 0; i < values.length; i++) {
      paint.color = colors[i];
      final barWidth = (values[i] / total) * size.width;

      // width가 0 이상일 때만 그리기
      if (barWidth > 0) {
        canvas.drawRect(
          Rect.fromLTWH(startX, 0, barWidth, size.height),
          paint,
        );
        startX += barWidth;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
