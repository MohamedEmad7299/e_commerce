
abstract class HomeState {}

class HomeInitialState extends HomeState {}
class HomeChangeBottomNavState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeSuccessState extends HomeState {}
class HomeErrorState extends HomeState {

  final String error;

  HomeErrorState(this.error);
}



class CategoriesInitialState extends HomeState {}
class CategoriesLoadingState extends HomeState {}
class CategoriesSuccessState extends HomeState {}
class CategoriesErrorState extends HomeState {
  final String error;

  CategoriesErrorState(this.error);
}



class FavoritesSuccessState extends HomeState {}
class FavoritesErrorState extends HomeState {
  final String error;

  FavoritesErrorState(this.error);
}
class FavoritesChangeState extends HomeState {}


class ProfileLoadingState extends HomeState {}
class UpdateProfileLoadingState extends HomeState {}
class ProfileSuccessState extends HomeState {}
class ProfileErrorState extends HomeState {

  final String error;

  ProfileErrorState(this.error);
}
