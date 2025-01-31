import 'package:delivery_app/common/model/cursor_pagination_model.dart';
import 'package:delivery_app/common/model/model_with_id.dart';
import 'package:delivery_app/common/provider/pagination_provider.dart';
import 'package:delivery_app/common/utils/pagination_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(BuildContext context, int index, T model);



class PaginationListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;

  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    super.key,
    required this.provider,
    required this.itemBuilder,
  });

  @override
  ConsumerState<PaginationListView> createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId> extends ConsumerState<PaginationListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(
      scrollController: scrollController,
      paginationProvider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    // 1. 맨 처음 로딩
    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2. 에러 발생
    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(
                    forceRefetch: true,
                  );
            },
            child: Text('다시 시도'),
          ),
        ],
      );
    }

    final cp = state as CursorPagination<T>; // 임시

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: scrollController,
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: cp is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('마지막 데이터입니다 ㅠㅠ'),
              ),
            );
          }

          final item = cp.data[index];

          return widget.itemBuilder(context, index, item);
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: 16);
        },
      ),
    );
  }
}
