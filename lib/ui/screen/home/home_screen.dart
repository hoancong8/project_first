import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_first/app/provider.dart';
import 'package:project_first/ui/screen/home/home_vm.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    return state.isLoading
        ? Center(child: const CircularProgressIndicator())
        : DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Home3443535'),
                actions: [
                  IconButton(icon: Icon(Icons.home), onPressed: () {}),
                  IconButton(icon: Icon(Icons.person), onPressed: () {}),
                ],
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.home)),
                    Tab(icon: Icon(Icons.video_call)),
                    Tab(icon: Icon(Icons.person)),
                  ],
                ),
              ),

              body: TabBarView(
                children: [
                  Column(
                    children: [
                      Text(state.user?.name ?? '243'),
                      Text(state.user?.email ?? '234'),
                      Text(state.user?.isOnline.toString() ?? "234"),
                      Text(state.user?.avtUrl ?? "234"),
                      Text(state.user?.id.toString() ?? "234"),
                      Text(state.user?.timeLogin.toString() ?? "234"),
                    ],
                  ),
                  Column(
                    children: [
                      Text(state.user?.name ?? '243'),
                      Text(state.user?.email ?? '234'),
                      Text(state.user?.isOnline.toString() ?? "234"),
                      Text(state.user?.avtUrl ?? "234"),
                      Text(state.user?.id.toString() ?? "234"),
                      Text(state.user?.timeLogin.toString() ?? "234"),
                    ],
                  ),
                  Column(
                    children: [
                      Text(state.user?.name ?? '243'),
                      Text(state.user?.email ?? '234'),
                      Text(state.user?.isOnline.toString() ?? "234"),
                      Text(state.user?.avtUrl ?? "234"),
                      Text(state.user?.id.toString() ?? "234"),
                      Text(state.user?.timeLogin.toString() ?? "234"),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
