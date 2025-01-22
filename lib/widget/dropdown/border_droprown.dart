import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class BorderDroprown extends StatelessWidget {
  final double width;
  final String selected;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  const BorderDroprown(
      {super.key,
      required this.items,
      required this.selected,
      required this.width,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 48,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<String>(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: CatchmongColors.black,
          ),
          isExpanded: true,
          underline: SizedBox(),
          value: selected,
          items: items,
          onChanged: onChanged,
        ));
  }
}
