import 'home_data.dart';

class HomeModel {

  dynamic status;
  dynamic message;
  HomeData? data;

  HomeModel({
      this.status, 
      this.message, 
      this.data,});

  HomeModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
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