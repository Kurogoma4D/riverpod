import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils.dart';

part 'old_lifecycles.g.dart';

final repositoryProvider = Provider<_MyRepo>((ref) {
  return _MyRepo();
});

class _MyRepo {
  Future<void> update(int i, {CancelToken? token}) async {}
}

/* SNIPPET START */
@riverpod
class MyNotifier extends _$MyNotifier {
  @override
  int build() {
    // 한 곳에서 코드를 읽고 쓰면 됩니다.
    final period = ref.watch(durationProvider);
    final timer = Timer.periodic(period, (t) => update());
    ref.onDispose(timer.cancel);

    return 0;
  }

  Future<void> update() async {
    await ref.read(repositoryProvider).update(state + 1);
    // `mounted`는 더 이상 없습니다!
    state++; //throw 될 수 있습니다
  }
}
