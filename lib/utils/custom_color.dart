import 'package:flutter/material.dart';

class CustomColor {
  static const Color inactiveBgColor = Colors.white;
  static const Color inactiveFgColor = Colors.black;
  static const Color toggleSwitchColor = Color(0xFFF1B858);
  static const Color medicalSeletionColor = Color(0xFFF1B858);
  static const Color dividerColor = Color(0xFFF1B858);
  static const Color transDivderColor = Color.fromARGB(255, 235, 227, 213);
  static Color backGroundColor = dividerColor.withOpacity(0.1);
  static Color vaccinRegColor = dividerColor.withOpacity(0.25);
  static  Color tappedColor =  dividerColor.withOpacity(0.5);
}
class TapDelay{
  static const int delayMs = 100;
}
class LoadingDuration{
  static const int duration = 3;
}