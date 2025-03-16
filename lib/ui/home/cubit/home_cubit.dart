
import 'package:e_commerce/data/models/home_models/HomeModel.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/network/end_points.dart';
import 'package:e_commerce/shared/consts.dart';
import 'package:e_commerce/ui/categories/categories_screen.dart';
import 'package:e_commerce/ui/favourites/favourites_screen.dart';
import 'package:e_commerce/ui/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../products/products_screen.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  HomeModel homeModel = HomeModel();

  void getHomeData() {

    emit(HomeLoadingState());

    DioHelper.getData(
      path: HOME,
      token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print("---------------->  " + homeModel.data!.products!.first.price.toString());
      emit(HomeSuccessState());
    },).catchError((error) {
      print(error.toString());
      emit(HomeErrorState(error.toString()));
    });
  }
}