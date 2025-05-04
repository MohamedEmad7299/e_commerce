
import 'package:e_commerce/data/models/cart_item.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/network/end_points.dart';
import 'package:e_commerce/network/models/products_models/Products_response_model.dart';
import 'package:e_commerce/shared/consts.dart';
import 'package:e_commerce/ui/cart/cart_screen.dart';
import 'package:e_commerce/ui/favourites/wish_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/service_locator.dart';
import '../../../network/models/products_models/Product.dart';
import '../../products/products_screen.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {

  final dioHelper = getIt<DioHelper>();

  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  ProductsResponseModel? productsResponseModel;

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  void getProducts() async {
    emit(HomeLoadingState());
    try {
      final response = await dioHelper.getData(path: PRODUCTS, token: token);
      productsResponseModel = ProductsResponseModel.fromJson(response.data);
      emit(HomeSuccessState());
    } catch (error) {
      emit(HomeErrorState(error.toString()));
    }
  }

  void searchProducts(String query) async {
    if (query.trim().isEmpty) {
      getProducts();
      return;
    }

    emit(HomeLoadingState());

    try {
      final response = await dioHelper.getData(
        path: 'products/search',
        query: {'q': query},
        token: token,
      );

      final result = ProductsResponseModel.fromJson(response.data);

      if (result.products == null || result.products!.isEmpty) {
        emit(HomeEmptySearchState());
      } else {
        productsResponseModel = result;
        emit(HomeSuccessState());
      }
    } catch (error) {
      emit(HomeErrorState(error.toString()));
    }
  }

  List<Product> wishList = [];

  void updateWishList(Product product) {
    if (inWishList(product)) {
      wishList.remove(product);
      emit(HomeRemoveFromWishListState());
    } else {
      wishList.add(product);
      emit(HomeAddToWishListState());
    }
  }

  bool inWishList(Product product) {
    return wishList.any((item) => item.id == product.id);
  }

  // cart
  List<CartItem> cart = [];

  void addToCart(Product product , int quantity) {
    cart.add(
      CartItem(
        product: product,
        count: quantity,
      ),
    );
    emit(ProductAddToCartState());
  }

  void removeFromCart(Product product) {
    cart.removeWhere((item) => item.product.id == product.id);
    emit(ProductRemoveFromCartState());
  }


  bool inCart(Product product) {
    return cart.any((item) => item.product.id == product.id);
  }
}
