class OtpModel {
  OtpModel({
      this.phone, 
      this.code,});

  OtpModel.fromJson(dynamic json) {
    phone = json['phone'];
    code = json['code'];
  }
  String? phone;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['code'] = code;
    return map;
  }

}