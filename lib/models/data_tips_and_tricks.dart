
import 'package:dentistReservationApp/utils/strings.dart';

class TipsAndTrick {
  final String title;
  final String image;
  final List<DetailTipsAndTrick> tipsAndTrikList;

  TipsAndTrick({this.title, this.image, this.tipsAndTrikList});
}

List<TipsAndTrick> tipsAndTricks = [
  TipsAndTrick(
      title: tips1,
      image: "assets/images/image1.jpg",
      tipsAndTrikList: [
        DetailTipsAndTrick(subtitle: subtitle1, description: desc1),
        DetailTipsAndTrick(subtitle: subtitle2, description: desc2),
        DetailTipsAndTrick(subtitle: subtitle3, description: desc3),
        DetailTipsAndTrick(subtitle: subtitle4, description: desc4),
      ]),
  TipsAndTrick(
      title: tips2,
      image: "assets/images/image2.jpg",
      tipsAndTrikList: [
        DetailTipsAndTrick(subtitle: subtitle5, description: desc5),
        DetailTipsAndTrick(subtitle: subtitle6, description: desc6),
        DetailTipsAndTrick(subtitle: subtitle7, description: desc7),
        DetailTipsAndTrick(subtitle: subtitle8, description: desc8),
      ]),
  TipsAndTrick(
      title: tips3,
      image: "assets/images/image3.jpg",
      tipsAndTrikList: [
        DetailTipsAndTrick(subtitle: subtitle9, description: desc9),
        DetailTipsAndTrick(subtitle: subtitle10, description: desc10),
        DetailTipsAndTrick(subtitle: subtitle11, description: desc11),
        DetailTipsAndTrick(subtitle: subtitle12, description: desc12),
      ]),
];

class DetailTipsAndTrick {
  final String subtitle;
  final String description;

  DetailTipsAndTrick({this.subtitle, this.description});
}
