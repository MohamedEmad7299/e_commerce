
abstract class HomeState {}

class HomeInitialState extends HomeState {}
class HomeChangeBottomNavState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeSuccessState extends HomeState {}
class HomeEmptySearchState extends HomeState {}
class HomeErrorState extends HomeState {

  final String error;

  HomeErrorState(this.error);
}


class ProductDetailsLoadingState extends HomeState {}
class ProductDetailsErrorState extends HomeState {

  final String error;

  ProductDetailsErrorState(this.error);
}

class ProductAddToCartState extends HomeState {}
class ProductRemoveToCartState extends HomeState {}
class ProductRemoveFromCartState extends HomeState {}

class HomeAddToWishListState extends HomeState {}
class HomeRemoveFromWishListState extends HomeState {}

