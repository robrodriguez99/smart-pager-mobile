
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
    _refreshTimer = Timer.periodic(Duration(minutes: 5), (_) { //TODO: CHECK THIS L8ER
      _refreshSubject.add(null);
    });

    _refreshSubject
        .throttleTime(Duration(minutes: 5))
        .listen((_) async {
          print('refreshing queue');
         await fetchQueue();
        });
  }

  Future<void> fetchQueue() async {
    print("entre a fetchQueue");
     final futureUser = ref.read(loggedUserProvider);
          if (futureUser != null) {
            final currentQueue = await ref.read(apiServiceProvider).getUserQueue(futureUser.email);
            if (currentQueue != null) {
              state = currentQueue;
            } else {
              state = null;
            }
          }
  }

  Future<void> refresh() async {
    _refreshSubject.add(null); 
  }
  

  void set(SmartPagerCurrentQueue currentQueue) => state = currentQueue;

  void cancelQueue() {
    ref.read(apiServiceProvider).cancelQueue(state!.email);
    refresh();
    state = null;
  }

  void clear() => state = null;
  
}
