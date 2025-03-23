import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/network/end_points.dart';
import 'package:e_commerce/shared/consts.dart';
import 'package:e_commerce/ui/sign_up/cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cache_helper/cache_helper.dart';
import '../../../network/models/register_models/register_model.dart';


class RegisterCubit extends Cubit<RegisterState> {

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;

  void register({
    required String name,
    required String email,
    required String password,
    required String phone
  }) {

    emit(RegisterLoadingState());

    DioHelper.postData(path: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: registerModel!.data!.token).then((value) {
        token = registerModel!.data!.token!;
        if (value!) {
          emit(RegisterSuccessState(registerModel!));
        }
      });
    },).catchError(
      (error) {
        print('register error: $error');
        emit(RegisterErrorState(error.toString()));
      },
    );
  }

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(RegisterChangePasswordVisibilityState());
  }
}
