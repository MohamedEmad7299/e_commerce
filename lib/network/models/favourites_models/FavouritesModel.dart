import 'favourites_data.dart';

class FavouritesModel {


  bool? status;
  String? message;
  FavouritesData? data;

  FavouritesModel({
      this.status, 
      this.message, 
      this.data,});

  FavouritesModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavouritesData.fromJson(json['data']) : null;
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