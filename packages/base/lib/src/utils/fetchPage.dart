part of base_lhe;

class PagingEvent {
  Future<void> fetchPage({
    required PagingController pagingController,
    required int pageSize,
    required Function(int) fetchData,
    required int pageKey,
  }) async {
    try {
      final newItems = await fetchData(pageKey);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }
}
