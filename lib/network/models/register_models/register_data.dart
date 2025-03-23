class RegisterData {

  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  RegisterData({
      this.name, 
      this.email, 
      this.phone, 
      this.id, 
      this.image, 
      this.token,});

  RegisterData.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['id'] = id;
    map['image'] = image;
    map['token'] = token;
    return map;
  }

}