

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_first/app/provider.dart';
import 'package:project_first/domain/usecases/post/GetPostUsecase.dart';
import 'package:project_first/domain/usecases/profile/get_profile_usecase.dart';
import 'package:project_first/ui/screen/home/home_state.dart';
import 'package:project_first/ui/screen/home/tab/news/news_state.dart';

final newsViewModelProvider =
StateNotifierProvider.autoDispose<NewsViewModel, NewsState>((ref) {
  return NewsViewModel(
      getPostUsecase: ref.watch(getPostUseCaseProvider)
  );
});

class NewsViewModel extends StateNotifier<NewsState>{
  final GetPostUsecase getPostUsecase;
  NewsViewModel({required this.getPostUsecase}):super(const NewsState());
  Future<void> getPost() async {
    state = state.copyWith(isLoading: true);
    try{
      final posts = await getPostUsecase.call();
      print("GET POST11 ${posts.length}");
      state = state.copyWith(isLoading: false, postDto: posts);
    }catch(e){
      debugPrint("GET PROFILE ở đấy ${e.toString()}");
      state = state.copyWith(isLoading: false, error: e.toString());
    }

  }
}