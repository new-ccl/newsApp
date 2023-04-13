import 'package:dio/dio.dart';
import 'package:newsapp/page/entity.dart';

class NewsTypeModel {
  Entity? data;

  Future<Entity?> getData()async{
    if (data == null){
      try{
        Response res = await Dio().get('http://10.0.2.2:5000/news/type');
        data = Entity.fromJson(res.data);
        return data;
      }catch(e){
        return null;
      }
    }
    return data;
  }

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  ));
}
