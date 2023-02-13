class User {
  User({
      this.id, 
      this.name, 
      this.phone, 
      this.email, 
      this.phoneverified, 
      this.city, 
      this.latitude, 
      this.longitude, 
      this.profileimage, 
      this.role, 
      this.createdAt, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    phoneverified = json['phoneverified'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    profileimage = json['profileimage'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  int? phone;
  String? email;
  int? phoneverified;
  dynamic city;
  dynamic latitude;
  dynamic longitude;
  String? profileimage;
  int? role;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['phoneverified'] = phoneverified;
    map['city'] = city;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['profileimage'] = profileimage;
    map['role'] = role;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}