

import '../../../network/models/login_models/Login_response_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {

  final LoginResponseModel loginResponse;
  LoginSuccessState(this.loginResponse);
}
class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}
class LoginChangePasswordVisibilityState extends LoginState {}