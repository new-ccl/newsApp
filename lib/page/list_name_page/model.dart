import 'package:dio/dio.dart';
import 'entity_list.dart';

class NewsListModel {
  NewsListEntity? data;
  List<Data> newsList = [];
  Future<List<Data>?> getData({required String type, int page = 1}) async {
    try {
      Response res = await _dio.get(
        "http://10.0.2.2:5000/news/list",
        queryParameters: {
          "type": type,
          "page": page,
        },
      );
      data = NewsListEntity.fromJson(res.data);
      var result = data?.data;
      if (result != null) {
        for (var item in result) {
          if (!newsList.any((data) => data.title == item.title && data.date == item.date && data.link == item.link)) {
            newsList.add(item); // 如果不存在，则添加到 newsList 中
          }
        }
        return newsList;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ),
  );
}