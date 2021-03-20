import 'package:flutter/material.dart';

const kBackGround = Color(0xFFF5F5F5);
const kPrimaryColor = Color(0xFFA760FF);
const kPrimaryGradientColor = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFDA8CFF), Color(0xFF9A55FF)]);
const kTitleTextColor = Color(0xFF333333);
const kSubtitleTextColor = Color(0xFFC4C4C4);

final Shader kGradientTextColor = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFDA8CFF), Color(0xFF9A55FF)])
    .createShader(Rect.fromLTWH(0.0, 0.0, 0.0, 0.0));

Gradient linearGradient = LinearGradient(colors: [
  Color(0xFFDA8CFF),
  Color(0xFF9A55FF),
]);

const kCardColor = Color(0xFFF9F9F9);
