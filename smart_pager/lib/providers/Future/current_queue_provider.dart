
import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_pager/data/models/current_queue_model.dart';
import 'package:smart_pager/providers/api_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_pager/providers/user_provider.dart';

part 'current_queue_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentQueue extends _$CurrentQueue {
  final _refreshSubject = PublishSubject<void>();
  late Timer _refreshTimer;
  @override
  SmartPagerCurrentQueue? build() => null;

 CurrentQueue() {
    _refreshTimer = Timer.periodic(Duration(seconds: 30), (_) {
      _refreshSubject.add(null);
    });

    _refreshSubject
        .throttleTime(Duration(seconds: 1))
        .listen((_) async {
          final futureUser = ref.read(loggedUserProvider);
          if (futureUser != null) {
            final currentQueue = await ref.read(apiServiceProvider).getUserQueue(futureUser.email);
            if (currentQueue != null) {
              state = currentQueue;
            }
          }
        });
  }

  Future<void> refresh() async {
    _refreshSubject.add(null);
    
  }
  //  Future<void> refresh(String email, String id) async {
  //   print("holis");
  //   final currentQueue = await ref.read(apiServiceProvider).getUserQueue(email);
  //   // final currentQueue = await ref.read(currentQueueRepositoryProvider).getCurrentQueueByEmail(email);
  //   if (currentQueue != null) {
  //     state = currentQueue;
  //   }
  // }

  void set(SmartPagerCurrentQueue currentQueue) => state = currentQueue;

  void updatePosition(int position) {
    state!.position = position;
    state = state!.copy();
  }

  void updateWaitingTime(int waitingTime) {
    state!.waitingTime = waitingTime;
    state = state!.copy();
  }

  void clear() => state = null;
  
}
