import 'package:dio/dio.dart';
import 'content_entity.dart';

class ContentModel {
  ContentEntity? entity;

  Future<ContentEntity?> getData({required String link}) async {
    if (entity == null) {
      try {
        var param = {"link": link};
        Response res = await _dio.get("http://10.0.2.2:5000/news/content",
            queryParameters: param);
        entity = ContentEntity.fromJson(res.data);
        return entity;
      } catch (e) {
        return null;
      }
    }
    return entity;
  }

  Dio _dio = Dio(BaseOptions(
      sendTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      connectTimeout: Duration(seconds: 60)));
}
