import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_manage_by_riverpod/layout/default_layout.dart';
import 'package:state_manage_by_riverpod/riverpod/listen_provider.dart';

class ListenProviderScreen extends ConsumerStatefulWidget {
  // stateful widget을 consumer state widget으로 변경
  const ListenProviderScreen({super.key});

  @override
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(
      length: 10,
      vsync: this,
      initialIndex: ref.read(listenProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(listenProvider, (previous, next) {
      //
      print('previous: $previous, next: $next');
      if (previous != next) {
        controller.animateTo(next);
      }
    });

    return DefaultLayout(
      title: 'ListenProviderScreen',
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                index.toString(),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 10 ? 10 : state + 1);
                },
                child: Text(
                  '다음',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(listenProvider.notifier)
                      .update((state) => state == 0 ? 0 : state - 1);
                },
                child: Text(
                  '뒤로',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
