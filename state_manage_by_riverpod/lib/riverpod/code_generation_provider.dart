import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// riverpod 2.0에서 바뀐 점
// 1) 어떤 프로바이더를 사용할지 고민할 필요 없음 (ex. Provider, FutureProvider, StreamProvider)
// 2) 파라미터(family)를 일반 함수처럼 사용할 수 있음

// 1) 아래 _testProvider를 아래 gState로 변경할 수 있음.
final _testProvider = Provider<String>((ref) => 'Hello, Riverpod!');

@riverpod
String gState(GStateRef ref) {
  return 'Hello, Riverpod!';
}

@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 2));

  return 10;
}

@Riverpod(
  keepAlive: true, // autoDispose를 해제 시키고 싶을 때 사용
)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 2));

  return 10;
}

// 2)
@riverpod
int gStateMultiply(
  GStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}

@riverpod
class GStateNotifier extends _$GStateNotifier {

  @override
  int build() {
    return 0; // 초기값
  }

  increment() {
    state++;
  }

  decrement() {
    state--;
  }
}




@riverpod
Future<int> delayedMultiply(DelayedMultiplyRef ref, {
  required int number1,
  required int number2,
}) async {
  await Future.delayed(Duration(seconds: 2));

  return number1 * number2;
}

final testGStateMultiplyProvider =
AutoDisposeProvider.family<int, (int, int)>((ref, params) {
  final (number1, number2) = params;
  return number1 * number2;
});