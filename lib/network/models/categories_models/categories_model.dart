import 'categories_data.dart';

class CategoriesModel {

  bool? status;
  dynamic message;
  CategoriesData? data;

  CategoriesModel({
      this.status, 
      this.message, 
      this.data,});

  CategoriesModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CategoriesData.fromJson(json['data']) : null;
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