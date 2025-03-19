class Product {


  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  Product({
      this.id, 
      this.price, 
      this.oldPrice, 
      this.discount, 
      this.image,});

  Product.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    return map;
  }

}