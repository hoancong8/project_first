import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_first/ui/screen/home/tab/news/news_vm.dart';
import 'package:project_first/ui/screen/home/tab/news/widget/item_post.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsViewModelProvider.notifier).getPost();
    });
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsViewModelProvider);
    return ListView.builder(
      // controller: _controller,
      itemCount: state.postDto?.length,
      itemBuilder: (context, index) {
        return PostItem(post: state.postDto![index],);
      },
    );
  }
}
