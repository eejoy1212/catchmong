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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(data.length, (index) {
        final total = data[index].reduce((a, b) => a + b);
        final percentages = data[index]
            .map((value) => (value / total * 100).toStringAsFixed(1))
            .toList();

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
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: CustomPaint(
                  size: Size(double.infinity, 20),
                  painter: _StackedBarPainter(data[index], colors),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(data[index].length, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "${percentages[i]}%",
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
    final total = values.reduce((a, b) => a + b);

    // 클리핑을 위한 RRect 생성
    final clipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(2), // 전체 스택을 감싸는 둥근 직사각형
    );

    // 클리핑 적용
    canvas.clipRRect(clipRect);

    // 배경 둥근 직사각형 그리기
    paint.color = Colors.grey[300]!;
    canvas.drawRRect(clipRect, paint);

    // 스택 막대 그리기
    double startX = 0;
    for (int i = 0; i < values.length; i++) {
      paint.color = colors[i];
      final barWidth = (values[i] / total) * size.width;
      canvas.drawRect(
        Rect.fromLTWH(startX, 0, barWidth, size.height),
        paint,
      );
      startX += barWidth;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
