import 'update_profile_data.dart';

class UpdateProfileModel {

  bool? status;
  String? message;
  UpdateProfileData? data;

  UpdateProfileModel({
      this.status, 
      this.message, 
      this.data,});

  UpdateProfileModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UpdateProfileData.fromJson(json['data']) : null;
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