import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/cache_helper/cache_helper.dart';
import 'package:e_commerce/shared/navigation_helper.dart';
import 'package:e_commerce/ui/home/home_screen.dart';
import 'package:e_commerce/ui/login/cubit/login_cubit.dart';
import 'package:e_commerce/ui/widgets/components.dart';
import 'package:e_commerce/ui/widgets/default_form_field.dart';
import '../../shared/consts.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _cacheHelper = CacheHelper();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            _cacheHelper.saveData(key: 'token', value: state.loginResponse.accessToken!).then((success) {
              if (success == true) {
                token = state.loginResponse.accessToken!;
                navigateAndReplacement(context, const HomeScreen());
              }
            });
          } else if (state is LoginErrorState) {
            toast(msg: state.error);
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Login to access your account',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    defaultFormField(
                      controller: _emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) => value.isEmpty ? 'Email must not be empty' : null,
                      prefixIcon: Icons.email,
                      label: 'Email',
                    ),
                    const SizedBox(height: 16),
                    defaultFormField(
                      controller: _passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (value) => value.isEmpty ? 'Password must not be empty' : null,
                      isPassword: cubit.isPassword,
                      suffixIconPressed: cubit.changePasswordVisibility,
                      suffixIcon: cubit.isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      prefixIcon: Icons.lock_outline,
                      label: 'Password',
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.logging(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            );
                          }
                        },
                        child: state is! LoginLoadingState
                            ? const Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold))
                            : const CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?', style: TextStyle(color: Colors.grey)),
                        TextButton(
                          onPressed: () {
                            // Navigate to sign up screen
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
