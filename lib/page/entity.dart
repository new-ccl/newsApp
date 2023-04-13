class Entity {
  Entity({
      this.data,});

  Entity.fromJson(dynamic json){
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class Data {
  Data({
    this.link,
    this.name,
    this.type,});

  Data.fromJson(dynamic json) {
    link = json['link'];
    name = json['name'];
    type = json['type'];
  }
  String? link;
  String? name;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['link'] = link;
    map['name'] = name;
    map['type'] = type;
    return map;
  }

}