class AppRequest {
  AppRequest({
      this.requestid, 
      this.name, 
      this.image, 
      this.state,});

  AppRequest.fromJson(dynamic json) {
    requestid = json['requestid'];
    name = json['name'];
    image = json['image'];
    state = json['state'];
  }
  int? requestid;
  String? name;
  String? image;
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestid'] = requestid;
    map['name'] = name;
    map['image'] = image;
    map['state'] = state;
    return map;
  }

}