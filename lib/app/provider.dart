import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_first/domain/usecases/register_usecase.dart';
import '../data/datasource/remote/auth_remote_datasource.dart';
import '../data/mapper/auth_mapper.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_usecase.dart';

// 1. Mappers
final authMapperProvider = Provider((ref) => AuthMapper());

// 2. Khai báo Dio
final dioProvider = Provider((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.16:3000', // URL Server của bạn
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Bạn có thể thêm Interceptors ở đây (ví dụ: để Log API hoặc xử lý Token)
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
});

// 3. Khai báo Datasource
final authRemoteDataSourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSource(dio);
});

// 4. Cập nhật Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final mapper = ref.watch(authMapperProvider);
  return AuthRepositoryImpl(remoteDataSource: remote, mapper: mapper);
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
// lib/app/provider.dart
