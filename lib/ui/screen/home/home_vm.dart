

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_first/app/provider.dart';
import 'package:project_first/domain/usecases/profile/get_profile_usecase.dart';
import 'package:project_first/ui/screen/home/home_state.dart';

final homeViewModelProvider =
StateNotifierProvider.autoDispose<HomeViewModel, ProfileState>((ref) {
  return HomeViewModel(
    getProfileUsecase: ref.watch(getProfileUseCaseProvider)
  );
});

class HomeViewModel extends StateNotifier<ProfileState>{
  final GetProfileUsecase getProfileUsecase;
  HomeViewModel({required this.getProfileUsecase}):super(const ProfileState());
  Future<void> getProfile() async {
    state = state.copyWith(isLoading: true);
    try{
      final user = await getProfileUsecase.call();
      state = state.copyWith(isLoading: false, user: user);
    }catch(e){
      debugPrint("GET PROFILE ${e.toString()}");
      state = state.copyWith(isLoading: false, error: e.toString());
    }

  }
}