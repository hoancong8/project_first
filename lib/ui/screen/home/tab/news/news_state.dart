import 'package:project_first/data/dto/auth/post_dto.dart';
import 'package:project_first/data/dto/auth/user_dto.dart';

class NewsState {
  final bool isLoading;
  final bool isSaving;
  final String? error;
  final String? successMessage;
  final List<PostDto>? postDto;

  const NewsState({
    this.isLoading = false,
    this.isSaving = false,
    this.error,
    this.successMessage,
    this.postDto,
  });

  NewsState copyWith({
    bool? isLoading,
    bool? isSaving,
    String? error,
    String? successMessage,
    List<PostDto>? postDto,
  }) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      error: error,
      successMessage: successMessage,
      postDto: postDto ?? this.postDto,
    );
  }
}
