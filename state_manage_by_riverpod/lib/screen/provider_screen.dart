import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_manage_by_riverpod/layout/default_layout.dart';
import 'package:state_manage_by_riverpod/riverpod/provider.dart';
import 'package:state_manage_by_riverpod/riverpod/state_notifier_provider.dart';

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filteredShoppingListProvider);

    print(state);

    return DefaultLayout(
      title: 'ProviderScreen',
      actions: [
        PopupMenuButton<FilterState>(
          itemBuilder: (_) => FilterState.values.map(
            (e) => PopupMenuItem(
              value: e,
              child: Text(
                e.name,
              ),
            ),
          ).toList(),
          onSelected: (value) {
            ref.read(filterProvider.notifier).update((state) => value);
            print(value);
          },
        ),
      ],
      body: ListView(
        children: state
            .map(
              (e) => CheckboxListTile(
                title: Text(e.name),
                value: e.hasBought,
                onChanged: (value) {
                  ref.read(shoppingListProvider.notifier).toggleHasBought(
                        name: e.name,
                      );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
