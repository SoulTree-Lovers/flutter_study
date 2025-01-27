import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    // 상태변화가 있을 때마다 호출
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // TODO: implement didUpdateProvider
    super.didUpdateProvider(provider, previousValue, newValue, container);

    print(
        '[PROVIDER UPDATED] provider: $provider, previousValue: $previousValue, newValue: $newValue');
  }

  @override
  void didAddProvider(
    // provider가 추가될 때 호출
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    // TODO: implement didAddProvider
    super.didAddProvider(provider, value, container);

    print('[PROVIDER ADDED] provider: $provider, value: $value');
  }

  @override
  void didDisposeProvider(
    // provider가 삭제될 때 호출
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    // TODO: implement didDisposeProvider
    super.didDisposeProvider(provider, container);

    print('[PROVIDER DISPOSED] provider: $provider');
  }


}
