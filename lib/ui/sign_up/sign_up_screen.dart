
import 'package:e_commerce/ui/login/login_screen.dart';
import 'package:e_commerce/ui/sign_up/cubit/register_cubit.dart';
import 'package:e_commerce/ui/sign_up/cubit/register_states.dart';
import 'package:e_commerce/ui/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/cache_helper/cache_helper.dart';
import '../../shared/consts.dart';
import '../../shared/funs.dart';
import '../home/home_screen.dart';
import '../style/colors.dart';
import '../widgets/components.dart';

class SignUpScreen extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context, state) {

          if (state is RegisterSuccessState) {

            if (state.registerModel.status!) {
              CacheHelper.saveData(key: 'token', value: state.registerModel.data!.token).then((value) {
                if (value!) {
                  token = state.registerModel.data!.token!;
                  navigateAndReplacement(context, HomeScreen());
                }
              });
            } else {
              toast(msg: state.registerModel.message!);
            }
          } else if (state is RegisterErrorState) {
            toast(msg: state.error);
          }

        },
        builder: (context, state) {

          var cubit = RegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hello!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Sign up to browse our hot offers',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            label: 'Name',
                            prefixIcon: Icons.person),
                        SizedBox(
                          height: 16,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Email must not be empty';
                              }
                              return null;
                            },
                            label: 'Email',
                            prefixIcon: Icons.email),
                        SizedBox(
                          height: 16,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Phone must not be empty';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefixIcon: Icons.phone),
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
                            return null;
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
                                cubit.register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text
                                );
                              }
                            },
                            child: state is! RegisterLoadingState
                                ? Text(
                              'SIGN UP',
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
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  overlayColor: cabaret75,
                                ),
                                onPressed: () {
                                  navigateTo(context, LoginScreen());
                                },
                                child: Text(
                                  'Sign In',
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
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}