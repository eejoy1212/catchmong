import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class PartnerContentChip extends StatelessWidget {
  final String title;
  final Image image;
  const PartnerContentChip(
      {super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
              border: Border.all(
                color: const Color(0xFFD9D9D9),
              )),
          child: Row(
            children: [
              image,
              Text(
                title,
                style: TextStyle(color: CatchmongColors.sub_gray, fontSize: 12),
              ),
            ],
          ),
        ));
  }
}
