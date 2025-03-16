import 'Banners.dart';
import 'Products.dart';

class HomeData {

  List<Banners>? banners;
  List<Products>? products;
  dynamic ad;

  HomeData({
      this.banners, 
      this.products, 
      this.ad,});

  HomeData.fromJson(dynamic json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners?.add(Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    ad = json['ad'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (banners != null) {
      map['banners'] = banners?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['ad'] = ad;
    return map;
  }

}