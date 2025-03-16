import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/shared/consts.dart';
import 'package:e_commerce/ui/home/home_screen.dart';
import 'package:e_commerce/ui/login/login_screen.dart';
import 'package:e_commerce/ui/onBoarding_screen/on_boarding_screen.dart';
import 'package:e_commerce/ui/style/colors.dart';
import 'package:flutter/material.dart';

import 'data/cache_helper/cache_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  skipBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';



  if (!skipBoarding){
    runApp(MyApp(startScreen: OnBoardingScreen()));
  } else if (token.isEmpty){
    runApp(MyApp(startScreen: LoginScreen()));
  } else {
    runApp(MyApp(startScreen: HomeScreen()));
  }
}

class MyApp extends StatelessWidget {

  final
  Widget startScreen;

  const MyApp({required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: cabaret75,
          selectionHandleColor: cabaret,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: startScreen,
    );
  }
}

