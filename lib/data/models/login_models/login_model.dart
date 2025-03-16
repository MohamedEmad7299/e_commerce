

import 'package:e_commerce/data/models/login_models/user_data.dart';

class LoginModel {

  bool? status;
  String? message;
  UserData? data;

  LoginModel({
      this.status, 
      this.message, 
      this.data,});

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}