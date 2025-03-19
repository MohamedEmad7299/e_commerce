import 'Product.dart';

class FavouritesData {

  dynamic id;
  Product? product;

  FavouritesData({
      this.id, 
      this.product,});

  FavouritesData.fromJson(dynamic json) {
    id = json['id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    return map;
  }

}