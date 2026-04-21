import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project_first/app/utili.dart';
import 'package:project_first/data/datasource/remote/abstract/auth_remote_datasource.dart';
import 'package:project_first/data/datasource/remote/abstract/profile_remote_datasource.dart';
import 'package:project_first/data/datasource/remote/implement/profile_remote_datasource_impl.dart';
import 'package:project_first/data/repositories/profile_repository_impl.dart';
import 'package:project_first/domain/repositories/profile_repository.dart';
import 'package:project_first/domain/usecases/auth/register_usecase.dart';
import 'package:project_first/domain/usecases/profile/get_profile_usecase.dart';
import '../data/datasource/remote/implement/auth_remote_datasource_impl.dart';
import '../data/mapper/auth_mapper.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/auth/login_usecase.dart';

// 1. Mappers
final authMapperProvider = Provider((ref) => AuthMapper());

// 2. Khai báo Dio
final dioProvider = Provider((ref) {
  print("ip : ${getIP()}");
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.32:5291',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true, // In ra gọn gàng hơn
        maxWidth: 90,
      ),
    );
  }
  final storage = FlutterSecureStorage();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read(key: 'token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },

      onError: (e, handler) async {
        // 🔴 Nếu token hết hạn
        if (e.response?.statusCode == 401) {
          await storage.delete(key: 'token');
          // 👉 có thể redirect về login
        }

        return handler.next(e);
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
});
// 3. Khai báo Datasource
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSourceImpl(dio);
});
final profileRemoteDataSourceProvider = Provider<ProfileRemoteDatasource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return ProfileRemoteDatasourceImpl(dio);
});


// 4. Cập nhật Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final mapper = ref.watch(authMapperProvider);
  return AuthRepositoryImpl(remoteDataSource: remote, mapper: mapper);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remote = ref.watch(profileRemoteDataSourceProvider);
  return ProfileRepositoryImpl(remoteDatasource: remote);
});


// 5. UseCases
final loginUseCaseProvider = Provider((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final registerUseCaseProvider = Provider((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUsecase(repository);
});

final getProfileUseCaseProvider = Provider((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetProfileUsecase(repository);

});
// lib/app/provider.dart
