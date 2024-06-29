import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pager/config/cellules/cards/notification_card.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/Future/notifications_provider.dart';
import 'package:smart_pager/providers/user_provider.dart';

class NotificationsView extends ConsumerWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureUser = ref.watch(loggedUserProvider);

    ref.read(notificationsProvider.notifier).refresh(futureUser!.id);
    final futureNotifications = ref.watch(notificationsProvider);

    
    // print(futureNotifications!.notifications[0].toJson());
      if(futureNotifications != null && futureNotifications.notifications.isNotEmpty) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: futureNotifications.notifications.length,
                        itemBuilder: (context, index) {
                            return NotificationCard(
                              id: futureNotifications.notifications[futureNotifications.notifications.length -1 - index].id,
                              title: futureNotifications.notifications[futureNotifications.notifications.length -1 - index].title,
                              description: futureNotifications.notifications[futureNotifications.notifications.length -1  - index].body,
                              time: getTimeSince(futureNotifications.notifications[futureNotifications.notifications.length -1 - index].date),
                              isRead: futureNotifications.notifications[futureNotifications.notifications.length -1 - index].isRead,
                            );
                                                    
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 10);
                        },
                      )
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
         return const Center( child: CustomText(text:'No hay notificaciones de momento\n ¡cuando te anotes en algun lugar te avisamos!', overflow: TextOverflow.ellipsis));
      }

  }

      String getTimeSince(DateTime date) {
        final now = DateTime.now();
        final difference = now.difference(date);
        // print('date: $date');
        if (difference.inDays > 0) {
          return '${difference.inDays} días';
        } else if (difference.inHours > 0) {
          return '${difference.inHours} horas';
        } else if (difference.inMinutes > 0) {
          return '${difference.inMinutes} minutos';
        } else {
          return '${difference.inSeconds} segundos';
        }
      }
    
    
    
  
}
    // print('futureNotifications: ${futureNotifications.value!.notifications.length}');
    // return const SingleChildScrollView(
    //   child: Padding(
    //     padding: EdgeInsets.all(16),
    //     child: Center(
    //       child: Stack(
    //         children: [
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               NotificationCard(
    //                 title: "tu mesa está lista",
    //                 description: "Anunciate en puerta con tu nombre",
    //                 time: "Hace 5 minutos",
    //                 isRead: false,
    //               ),
                  
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
