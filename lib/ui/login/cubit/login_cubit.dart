import 'package:e_commerce/data/cache_helper/cache_helper.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/network/end_points.dart';
import 'package:e_commerce/ui/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/login_models/login_model.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginResponse;

  void loging({
    required String email,
    required String password,
  }) {

    emit(LoginLoadingState());

    DioHelper.postData(path: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginResponse = LoginModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: loginResponse!.data!.token).then((value) {
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
