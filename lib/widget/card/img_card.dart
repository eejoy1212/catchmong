import 'package:flutter/material.dart';

class ImgCard extends StatelessWidget {
  final String path;
  const ImgCard({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path, // 이미지 경로
      fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 40),
              Text(
                '이미지를 불러올 수\n 없습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        );
      },
    );
  }
}
