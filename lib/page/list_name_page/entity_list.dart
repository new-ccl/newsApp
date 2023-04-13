class NewsListEntity {
  NewsListEntity({
      this.currentPage, 
      this.data, 
      this.maxPage, 
      this.type,});

  NewsListEntity.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    maxPage = json['max_page'];
    type = json['type'];
  }
  int ?currentPage;
  List<Data> ?data;
  int ?maxPage;
  String ?type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['max_page'] = maxPage;
    map['type'] = type;
    return map;
  }


}
class Data {
  Data({
    this.date,
    this.link,
    this.title,});

  Data.fromJson(dynamic json) {
    date = json['date'];
    link = json['link'];
    title = json['title'];
  }
  String? date;
  String? link;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['link'] = link;
    map['title'] = title;
    return map;
  }

}