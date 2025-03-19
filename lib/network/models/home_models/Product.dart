class Product {


  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  dynamic image;
  dynamic name;
  dynamic description;
  List<dynamic> images = [];
  dynamic inFavorites;
  dynamic inCart;

  Product({
      this.id, 
      this.price, 
      this.oldPrice, 
      this.discount, 
      this.image, 
      this.name, 
      this.description, 
      this.images = const [],
      this.inFavorites, 
      this.inCart,});

  Product.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    map['name'] = name;
    map['description'] = description;
    map['images'] = images;
    map['in_favorites'] = inFavorites;
    map['in_cart'] = inCart;
    return map;
  }

}