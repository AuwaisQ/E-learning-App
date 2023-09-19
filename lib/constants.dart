// ignore_for_file: non_constant_identifier_names

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

//Blue Color
const Color primaryColor = Color(0xFF4285F4);
//Yellow Color
const Color secondaryColor = Color(0xFFF4B400);
//Red Color
const Color redColor = Color(0xFFDB4437);
//Green Color
const Color greenColor = Color(0xFF0F9D58);

 Widget EnterAnimation(Widget child){
  return DelayedDisplay(
    slidingCurve: Curves.easeInOutBack,
    slidingBeginOffset: const Offset(0, -0.09),
    delay: const Duration(milliseconds: 200),
    child: child,);
}

const TextStyle titleStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle subTitle = TextStyle(
  fontSize: 13,
  color: Colors.black54,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);

const TextStyle headline = TextStyle(
  color: Colors.black,
  fontSize: 17,
  letterSpacing: 0.5,
  fontWeight: FontWeight.w600,
);

const TextStyle headline1 = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.bold,
  letterSpacing: 1
);

const TextStyle buttonTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

const TextStyle buttonSubTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5
);

const TextStyle blueButtonSubTitle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5
);