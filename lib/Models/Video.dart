class Video {
  Video({
      this.id, 
      this.userid, 
      this.title, 
      this.video, 
      this.description, 
      this.createdAt, 
      this.updatedAt,});

  Video.fromJson(dynamic json) {
    id = json['id'];
    userid = json['userid'];
    title = json['title'];
    video = json['video'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? userid;
  String? title;
  String? video;
  String? description;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userid'] = userid;
    map['title'] = title;
    map['video'] = video;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}