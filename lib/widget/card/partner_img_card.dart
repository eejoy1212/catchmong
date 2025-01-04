import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:flutter/material.dart';

class PartnerImgCard extends StatelessWidget {
  final String? path;
  final bool isLocal;
  final void Function() onDelete;
  final void Function() onTab;

  const PartnerImgCard({
    super.key,
    this.path,
    this.isLocal = false,
    required this.onDelete,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTab,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: CatchmongColors.gray100,
                ),
              ),
              child: path == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "첨부한\n가게사진",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CatchmongColors.sub_gray,
                          ),
                        ),
                      ],
                    )
                  : ImgCard(
                      path: path!,
                      isLocal: isLocal,
                    ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: onDelete,
            child: Container(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.close,
                color: CatchmongColors.gray400,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
