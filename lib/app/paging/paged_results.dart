class PagedResults<T> {
  final List<T> items;
  final bool hasMore;
  PagedResults({required this.items, required this.hasMore});
}
