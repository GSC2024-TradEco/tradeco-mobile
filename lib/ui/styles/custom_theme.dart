// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

class CustomTheme {
  static _Colors color = _Colors();
  static _FontWeights fontWeight = _FontWeights();
}

class _Colors {
  Color base1 = const Color(0xff36A03D);
  Color base2 = const Color(0xffD1EED3);
  Color background1 = const Color(0xffF2FFF2);
  Color background2 = const Color(0xff98D19B);
  List<Color> gradientBackground1 = [
    const Color(0xff36A03D),
    const Color(0xff98D19B),
    const Color(0xffF2FFF2),
  ];
}

class _FontWeights {
  FontWeight light = FontWeight.w300;
  FontWeight regular = FontWeight.normal;
  FontWeight medium = FontWeight.w500;
  FontWeight semibold = FontWeight.w600;
  FontWeight bold = FontWeight.bold;
}
