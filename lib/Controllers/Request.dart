class Request {
  Request({
      this.id, 
      this.userid, 
      this.followerid, 
      this.state, 
      this.createdAt, 
      this.updatedAt,});

  Request.fromJson(dynamic json) {
    id = json['id'];
    userid = json['userid'];
    followerid = json['followerid'];
    state = json['state'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userid;
  int? followerid;
  String? state;
  dynamic createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userid'] = userid;
    map['followerid'] = followerid;
    map['state'] = state;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}