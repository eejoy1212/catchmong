import 'dart:io';

import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/widget/card/partner_img_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SingleImgBtn extends StatelessWidget {
  final Function(XFile) onImageSelected;
  final File? image;
  final void Function() onDelete;
  const SingleImgBtn({
    super.key,
    required this.onImageSelected,
    this.image,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath = image?.path ?? "";
    final bool isLocal = !imagePath.contains('uploads');
    return image == null
        ? InkWell(
            onTap: () async {
              print("갤러리 열기");
              final ImagePicker picker = ImagePicker();
              final XFile? pickedFile = await picker.pickImage(
                source: ImageSource.gallery, // or ImageSource.camera
                maxWidth: 800, // Optional: Resize the image
                maxHeight: 800,
              );

              if (pickedFile != null) {
                final newImagePath = pickedFile.path;
                onImageSelected(pickedFile);
                //이미지 경로 넣기
                // if (controller.editing.value != null) {
                //   controller.editing.value =
                //       controller.editing.value!.copyWith(
                //     images: [
                //       ...(controller
                //               .editing.value?.images ??
                //           []),
                //       newImagePath,
                //     ],
                //   );
                // }
              }
            },
            child: Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  SvgPicture.asset('assets/images/img-plus.svg'),
                  Text(
                    "사진등록",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: CatchmongColors.gray100,
                ),
              ),
            ),
          )
        : PartnerImgCard(
            path: isLocal ? imagePath : "http://$myPort:3000/$imagePath",
            isLocal: isLocal, // 로컬 이미지 여부 전달
            onDelete: onDelete,
            onTab: () {
              // print("Tapped image at index $idx");
            },
          );
  }
}
