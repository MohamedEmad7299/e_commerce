
import 'package:flutter/material.dart';

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndReplacement(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

void onSkipBoarding(context, widget , cacheHelper) {
  cacheHelper.saveData(key: 'onBoarding', value: true).then(
    (value) {
      if (value!) {
        navigateAndReplacement(context, widget);
      }
    },
  );
}
