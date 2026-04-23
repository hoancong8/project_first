import 'package:project_first/data/dto/auth/user_dto.dart';

class PostDto {
  final String id;
  final String content;
  final String createdAt;
  final List<String> images;
  final List<String> videos;
  final int likeCount, commentCount;
  final UserDto user;

  PostDto({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.images,
    required this.videos,
    required this.likeCount,
    required this.commentCount,
    required this.user,
  });

  factory PostDto.fromJson(Map<String, dynamic> json) {
    return PostDto(
      // Bỏ ['data'] vì json lúc này đã là nội dung của 1 Post rồi
      id: json['id']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      // Ép kiểu List an toàn
      images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      videos: (json['videos'] as List?)?.map((e) => e.toString()).toList() ?? [],
      likeCount: json['likeCount'] as int? ?? 0,
      commentCount: json['commentCount'] as int? ?? 0,
      // User cũng nằm trực tiếp trong Post json
      user: UserDto.fromJson(json['user'] ?? {}),
    );
  }
}