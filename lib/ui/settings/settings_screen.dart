import 'package:e_commerce/cubit/cubit.dart';
import 'package:e_commerce/cubit/home_states.dart';
import 'package:e_commerce/ui/widgets/default_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/funs.dart';
import '../style/colors.dart';

class SettingsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    return cubit.profileModel == null
        ? Center(child: CircularProgressIndicator())
        : BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is ProfileSuccessState) {
                nameController.text = cubit.profileModel!.data!.name!;
                emailController.text = cubit.profileModel!.data!.email!;
                phoneController.text = cubit.profileModel!.data!.phone!;
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is UpdateProfileLoadingState)
                        LinearProgressIndicator(
                          color: cabaret,
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
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
                              return 'email must not be empty';
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
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefixIcon: Icons.phone),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity, // Set width
                        height: 60, // Set height
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updateProfileData(
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    name: nameController.text);
                              }
                            },
                            child: Text(
                              'UPDATE INFO',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(
                        height: 16,
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
                            signOut(context);
                          },
                          child: state is! ProfileLoadingState
                              ? Text(
                                  'SIGN OUT',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              : CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
