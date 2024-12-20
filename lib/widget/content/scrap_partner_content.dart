import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/card/scrap_partner_card.dart';
import 'package:catchmong/widget/status/star_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrapPartnerContent extends StatelessWidget {
  final List<Partner> partners;
  const ScrapPartnerContent({super.key, required this.partners});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: partners.length,
        itemBuilder: (context, index) {
          return ScrapPartnerCard(
            partner: partners[index],
          );
        });
  }
}
