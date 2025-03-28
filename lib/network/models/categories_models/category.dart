
class Category {

  int? id;
  String? name;
  String? image;

  Category({
    this.id,
    this.name,
    this.image,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {

    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}