
import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/shared/consts.dart';
import 'package:e_commerce/ui/home/cubit/cubit.dart';
import 'package:e_commerce/ui/home/home_screen.dart';
import 'package:e_commerce/ui/home/cubit/home_states.dart';
import 'package:e_commerce/ui/login/login_screen.dart';
import 'package:e_commerce/ui/onBoarding_screen/on_boarding_screen.dart';
import 'package:e_commerce/ui/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/cache_helper/cache_helper.dart';
import 'di/service_locator.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  setupLocator();
  final cacheHelper = getIt<CacheHelper>();
  skipBoarding = cacheHelper.getData(key: 'onBoarding',) ?? false;
  token = cacheHelper.getData(key: 'token') ?? '';

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

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
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getProducts(),
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            theme: lightTheme(),
            debugShowCheckedModeBanner: false,
            home: startScreen,
          );
        },
      ),
    );
  }
}

