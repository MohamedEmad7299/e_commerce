import 'package:e_commerce/data/cache_helper/cache_helper.dart';
import 'package:e_commerce/shared/funs.dart';
import 'package:e_commerce/ui/home/home_screen.dart';
import 'package:e_commerce/ui/login/cubit/login_cubit.dart';
import 'package:e_commerce/ui/sign_up/sign_up_screen.dart';
import 'package:e_commerce/ui/style/colors.dart';
import 'package:e_commerce/ui/widgets/components.dart';
import 'package:e_commerce/ui/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is LoginSuccessState) {

          if (state.loginResponse.status!) {
            CacheHelper.saveData(key: 'token', value: state.loginResponse.data!.token).then((value) {
              if (value!) {
                navigateAndReplacement(context, HomeScreen());
              }
            });
          } else {
            toast(msg: state.loginResponse.message!);
          }
        } else if (state is LoginErrorState) {
          toast(msg: state.error);
        }
      }, builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
            appBar: AppBar(),
            body: Container(
              padding: EdgeInsetsDirectional.only(start: 16, end: 16),
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Login to access your account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 32),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Email must not be empty';
                        }
                      },
                      prefixIcon: Icons.email,
                      label: 'Email',
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Password must not be empty';
                        }
                      },
                      isPassword: cubit.isPassword,
                      suffixIconPressed: () {
                        cubit.changePasswordVisibility();
                      },
                      suffixIcon: cubit.isPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      prefixIcon: Icons.lock_outline,
                      label: 'Password',
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity, // Set width
                      height: 60, // Set height
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cabaret,
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.loging(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: state is! LoginLoadingState
                            ? Text(
                                'LOGIN',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            : CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              overlayColor: cabaret75,
                            ),
                            onPressed: () {
                              navigateTo(context, SignUpScreen());
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: cabaret,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
