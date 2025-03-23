import 'profile_data.dart';

class ProfileModel {
  ProfileModel({
      this.status, 
      this.message, 
      this.data,});

  ProfileModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  ProfileData? data;

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