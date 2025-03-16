import 'package:e_commerce/data/cache_helper/cache_helper.dart';
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

void onSkipBoarding(context, widget) {
  CacheHelper.saveData(key: 'onBoarding', value: true).then(
    (value) {
      if (value!) {
        navigateAndReplacement(context, widget);
      }
    },
  );
}
