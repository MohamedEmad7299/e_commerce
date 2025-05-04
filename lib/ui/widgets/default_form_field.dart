

import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required FormFieldValidator validate,
  required String label,
  IconData? suffixIcon,
  IconData? prefixIcon,
  bool readOnly = false,
  Function()? suffixIconPressed
}){

  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit ?? (value) {},
    onChanged: onChange ?? (value){},
    validator: validate,
    readOnly: readOnly,
    onTap: onTap,
    cursorColor: Colors.black,
    decoration: InputDecoration(
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      label: Text(
        label,
      ),
      suffixIcon: IconButton(
          onPressed: suffixIconPressed, icon: Icon(suffixIcon)
      ),
      prefixIcon: Icon(
          prefixIcon,
        color: Colors.deepPurple,
      ),
      border: OutlineInputBorder(

      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
        ),
      ),
    ),
  );
}