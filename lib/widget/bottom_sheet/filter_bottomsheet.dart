import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      // bottom: false,
      child: DraggableScrollableSheet(
        initialChildSize: 0.5, // 처음 표시되는 크기 (화면 높이의 50%)
        minChildSize: 0.1, // 최소 크기 (화면 높이의 30%)
        maxChildSize: 0.9, // 최대 크기 (화면 높이의 90%)
        expand: false, // 드래그로 최대 크기로 확장 불가능
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: ListView(
              controller: scrollController, // 스크롤 컨트롤러 연결
              children: [
                // 상단 핸들
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // 필터 제목
                const Text(
                  "필터",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // 정렬 옵션
                const Text(
                  "정렬",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildChip("인기순", true),
                    _buildChip("최신순", false),
                    _buildChip("리뷰순", false),
                  ],
                ),
                const SizedBox(height: 20),
                // 영업 시간 옵션
                const Text(
                  "영업 시간",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildChip("영업중", true),
                    _buildChip("24시간 영업", false),
                  ],
                ),
                const SizedBox(height: 20),
                // 속성 옵션
                const Text(
                  "속성",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildChip("예약", false),
                    _buildChip("픽업", false),
                  ],
                ),
                const SizedBox(height: 20),
                // 음식 종류 옵션
                const Text(
                  "음식 종류",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildChip("한식", false),
                    _buildChip("양식", false),
                    _buildChip("아시아음식", false),
                    _buildChip("일식", false),
                    _buildChip("중식", false),
                    _buildChip("분식", false),
                    _buildChip("카페", false),
                    _buildChip("기타", false),
                  ],
                ),
                const SizedBox(height: 20),
                // 서비스 옵션
                const Text(
                  "서비스",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildChip("주차", false),
                    _buildChip("쿠폰", false),
                    _buildChip("아기좌석", false),
                    _buildChip("애견동반", false),
                  ],
                ),
                const SizedBox(height: 20),
                // 초기화 버튼
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // 초기화 로직
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("초기화"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        // 선택 상태 변경 로직
      },
      selectedColor: Colors.purple,
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }
}
