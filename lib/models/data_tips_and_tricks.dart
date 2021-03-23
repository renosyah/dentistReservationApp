import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TipsAndTrick {
  final String title;
  final String image;
  final List<DetailTipsAndTrick> tipsAndTrikList;

  TipsAndTrick({this.title, this.image, this.tipsAndTrikList});

  List<TipsAndTrick> getListTrickAndTips(BuildContext context) {
    return [
      TipsAndTrick(
          title: AppLocalizations.of(context).tips1,
          image: "assets/images/image1.jpg",
          tipsAndTrikList: [
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle1, description: AppLocalizations.of(context).desc1),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle2, description: AppLocalizations.of(context).desc2),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle3, description: AppLocalizations.of(context).desc3),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle4, description: AppLocalizations.of(context).desc4),
          ]),
      TipsAndTrick(
          title: AppLocalizations.of(context).tips2,
          image: "assets/images/image2.jpg",
          tipsAndTrikList:[
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle5, description: AppLocalizations.of(context).desc5),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle6, description: AppLocalizations.of(context).desc6),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle7, description: AppLocalizations.of(context).desc7),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle8, description: AppLocalizations.of(context).desc8),
          ]),
      TipsAndTrick(
          title: AppLocalizations.of(context).tips3,
          image: "assets/images/image3.jpg",
          tipsAndTrikList: [
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle9, description: AppLocalizations.of(context).desc9),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle10, description: AppLocalizations.of(context).desc10),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle11, description: AppLocalizations.of(context).desc11),
            DetailTipsAndTrick(subtitle: AppLocalizations.of(context).subtitle12, description: AppLocalizations.of(context).desc12),
          ]),
    ];
  }
}


class DetailTipsAndTrick {
  final String subtitle;
  final String description;

  DetailTipsAndTrick({this.subtitle, this.description});
}
