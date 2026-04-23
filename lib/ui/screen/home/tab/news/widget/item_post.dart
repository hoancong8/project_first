import 'package:flutter/material.dart';
import 'package:project_first/data/dto/auth/post_dto.dart';

class PostItem extends StatelessWidget {
  final PostDto post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildContent(),
            if (post.images.isNotEmpty) _buildImages(),
            const SizedBox(height: 10),
            _buildStats(),
            const Divider(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  // 👤 Header (avatar + name + time)
  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(post.user.avtUrl?? "https://via.placeholder.com/150"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name?? "Unknown",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                _formatTime(post.createdAt),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        const Icon(Icons.more_horiz)
      ],
    );
  }

  // 📝 Content
  Widget _buildContent() {
    return Text(
      post.content,
      style: const TextStyle(fontSize: 14),
    );
  }

  // 🖼️ Images grid
  Widget _buildImages() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        itemCount: post.images.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              post.images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  // ❤️ Like + Comment count
  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("👍 ${post.likeCount}"),
        Text("${post.commentCount} comments"),
      ],
    );
  }

  // 🔘 Actions
  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _ActionButton(icon: Icons.thumb_up_alt_outlined, label: "Like"),
        _ActionButton(icon: Icons.comment_outlined, label: "Comment"),
        _ActionButton(icon: Icons.share_outlined, label: "Share"),
      ],
    );
  }

  // 🕒 Format time
  String _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return "";

    final time = DateTime.tryParse(timeStr);
    if (time == null) return "";

    final diff = DateTime.now().difference(time);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m";
    if (diff.inHours < 24) return "${diff.inHours}h";
    return "${diff.inDays}d";
  }
}

// reusable button
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}