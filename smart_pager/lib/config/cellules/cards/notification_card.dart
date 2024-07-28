import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/Future/notifications_provider.dart';
import 'package:smart_pager/providers/user_provider.dart';

class NotificationCard extends ConsumerStatefulWidget {
  final String? title, description, time;
  bool? isRead;
  final String? id;

  NotificationCard({super.key, this.title, this.description, this.time, this.isRead, this.id});

  @override
  ConsumerState<NotificationCard> createState() => _NotificationCardState();

}
  class _NotificationCardState extends ConsumerState<NotificationCard> {
    String get title => widget.title!;
    String get description => widget.description!;
    String get time => widget.time!;
    bool get isRead => widget.isRead!;
    String get id => widget.id!;

    @override
    Widget build(BuildContext context) {
      // ref.read(notificationsProvider.notifier).refresh(futureUser!.id);
      return GestureDetector(
        onTap: () {
          ref.read(notificationsProvider.notifier).markNotificationAsRead(id);
          // GoRouter.of(context).pushNamed(
          //               'current-notification',
          //               pathParameters: {'title': title, 'description': description},
          //             );
          // ref.read(notificationsProvider.notifier).refresh(futureUser.id);

          //set isRead to true
          setState(() {
          widget.isRead = true;
        });
          
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isRead! ? Colors.white : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    isRead! ? Icons.mail_outline : Icons.mail,
                    color: isRead! ? Colors.grey : Colors.blue,
                  ),
                  const SizedBox(width: 10), // SizedBox is a box with a specified size.
                  CustomText(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                  ),
                ],
                
              ),
              
              const SizedBox(height: 5),
              CustomText(
                text: description!,
                fontSize: 15,
                color: Colors.grey,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 5),
              CustomText(
                text: time!,
                fontSize: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
    }

}