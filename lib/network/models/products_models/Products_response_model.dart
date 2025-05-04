import 'Product.dart';

class ProductsResponseModel {
  ProductsResponseModel({
      this.products, 
      this.total, 
      this.skip, 
      this.limit,});

  ProductsResponseModel.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
  List<Product>? products;
  dynamic total;
  dynamic skip;
  dynamic limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }

}