

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast({required String msg}) async {

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}


Widget categoryItem({required String image, required String name}) => Container(
  padding: EdgeInsets.symmetric(horizontal: 8),
  color: Colors.white70,
  width: 100,
  height: 100,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(image),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          textAlign: TextAlign.center,
          name,
          style: TextStyle(
            fontSize: 14,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  ),
);