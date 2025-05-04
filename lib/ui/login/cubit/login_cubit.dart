import 'package:e_commerce/data/cache_helper/cache_helper.dart';
import 'package:e_commerce/di/service_locator.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/network/end_points.dart';
import 'package:e_commerce/shared/consts.dart';
import 'package:e_commerce/ui/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/models/login_models/Login_response_model.dart';

class LoginCubit extends Cubit<LoginState> {

  final dioHelper = getIt<DioHelper>();
  final cacheHelper = getIt<CacheHelper>();

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginResponseModel? loginResponse;

  void logging({
    required String email,
    required String password,
  }) {

    emit(LoginLoadingState());

    dioHelper.postData(path: AUTH_LOGIN, data: {
      'username': email,
      'password': password,
    }).then((value) {
      loginResponse = LoginResponseModel.fromJson(value.data);
      cacheHelper.saveData(key: 'token', value: loginResponse!.accessToken).then((value) {
        token = loginResponse!.accessToken!;
        if (value!) {
          emit(LoginSuccessState(loginResponse!));
        }
      });
    },).catchError(
      (error) {
        print('login error: $error');
        emit(LoginErrorState(error.toString()));
      },
    );
  }

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(LoginChangePasswordVisibilityState());
  }
}
