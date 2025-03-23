import 'register_data.dart';

class RegisterModel {

  bool? status;
  String? message;
  RegisterData? data;

  RegisterModel({
      this.status, 
      this.message, 
      this.data,});

  RegisterModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RegisterData.fromJson(json['data']) : null;
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