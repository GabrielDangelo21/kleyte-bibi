import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFF9F0FE),
  100: Color(0xFFEFDAFE),
  200: Color(0xFFE5C2FD),
  300: Color(0xFFDBAAFC),
  400: Color(0xFFD397FB),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFFC67DF9),
  700: Color(0xFFBE72F9),
  800: Color(0xFFB868F8),
  900: Color(0xFFAC55F6),
});
const int _primaryPrimaryValue = 0xFFCB85FA;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFF9F1FF),
  700: Color(0xFFECD8FF),
});
const int _primaryAccentValue = 0xFFFFFFFF;
