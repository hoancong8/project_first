import 'package:dio/dio.dart';
import 'package:project_first/data/datasource/remote/abstract/post_remote_datasource.dart';
import 'package:project_first/data/dto/auth/post_dto.dart';


class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  final Dio _dio;
  PostRemoteDataSourceImpl(this._dio);
  @override
  Future<List<PostDto>> getPost() async {
    try {
      final response = await _dio.post('/api/Posts/recommend-post');
      // PHẢI lấy trường 'data' từ trong response.data
      final List listData = response.data['data'] as List? ?? [];
      print("reponse post ở đây: ${listData.length}+ ${listData.first}");
      return listData.map((e) => PostDto.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }

  }
}
