import 'dart:io';

import 'package:flutter/material.dart';

class ImgCard extends StatelessWidget {
  final String path;
  final bool isLocal;
  const ImgCard({super.key, required this.path, this.isLocal = false});

  @override
  Widget build(BuildContext context) {
    if (isLocal) {
      print("로컬일때 이미지>>>$isLocal%%$path");
    }

    return isLocal
        ? Image.file(
            File(path), // 이미지 경로
            fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 40),
                    Text(
                      '이미지를 불러올 수\n 없습니다cd.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              );
            },
          )
        : Image.network(
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
