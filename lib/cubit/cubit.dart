import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/network/end_points.dart';
import 'package:e_commerce/network/models/favourites_models/FavouritesModel.dart';
import 'package:e_commerce/shared/consts.dart';
import 'package:e_commerce/ui/categories/categories_screen.dart';
import 'package:e_commerce/ui/favourites/favourites_screen.dart';
import 'package:e_commerce/ui/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/models/home_models/HomeModel.dart';
import '../network/models/categories_models/categories_model.dart';
import '../ui/products/products_screen.dart';
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

  HomeModel? homeModel;

  Map<int, bool> favourites = {};

  void getHomeData() {

    emit(HomeLoadingState());

    DioHelper.getData(path: HOME, token: token).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        for (var element in homeModel!.data!.products!) {
          favourites.addAll({element.id!: element.inFavorites!});
        }
        emit(HomeSuccessState());
      },
    ).catchError((error) {
      emit(HomeErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  bool errorShown = false;

  void setErrorShown(bool value) {
    errorShown = value;
  }

  void getCategoriesData() {

    DioHelper.getData(path: CATEGORIES).then(
          (value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(CategoriesSuccessState());
      },
    ).catchError((error) {
      emit(CategoriesErrorState(error.toString()));
    });
  }

  FavouritesModel? favouritesModel;

  void updateFavourites(int productId) {

    favourites[productId] = !favourites[productId]!;
    emit(FavoritesChangeState());

    DioHelper.postData(
      path: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {

      errorShown = false;

      favouritesModel = FavouritesModel.fromJson(value.data);

      if (!favouritesModel!.status!) {
        favourites[productId] = !favourites[productId]!; // Revert change
        emit(FavoritesErrorState(favouritesModel!.message!));
      } else {
        emit(FavoritesSuccessState());
      }

    },).catchError((error) {
      favourites[productId] = !favourites[productId]!; // Revert on error
      emit(FavoritesErrorState(error.toString()));
    });
  }
}
