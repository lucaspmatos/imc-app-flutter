import 'dart:math';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

String determineIMC(double value) {
  if (value < 15.0) {
    return 'Very severely underweight';
  } else if (value >= 15.0 && value < 16.0) {
    return 'Severely underweight';
  } else if (value >= 16.0 && value < 18.5) {
    return 'Underweight';
  } else if (value >= 18.5 && value < 25.0) {
    return 'Normal (healthy weight)';
  } else if (value >= 25.0 && value < 30.0) {
    return 'Overweight';
  } else if (value >= 30.0 && value < 35.0) {
    return 'Moderately obese';
  } else if (value >= 35.0 && value < 40.0) {
    return 'Severely obese';
  } else if (value >= 40) {
    return 'Very serverely obese';
  } else {
    return '';
  }
}

double calculator(double height, double weight) {
  if (height <= 0.0) return 0.0;
  double imcValue = (weight / pow(height / 100, 2));
  return imcValue;
}

bool isEmptyString(String string) {
  return string.isEmpty;
}

Future<int> loadValue() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int? data = preferences.getInt('data');

  if (data != null) {
    return data;
  } else {
    return 0;
  }
}

void saveValue(int value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('data', value);
}
