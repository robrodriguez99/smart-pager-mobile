import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pager/config/cellules/cards/notification_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
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

    if (futureNotifications != null &&
        futureNotifications.notifications.isNotEmpty) {
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
                          id: futureNotifications
                              .notifications[
                                  futureNotifications.notifications.length -
                                      1 -
                                      index]
                              .id,
                          title: futureNotifications
                              .notifications[
                                  futureNotifications.notifications.length -
                                      1 -
                                      index]
                              .title,
                          description: futureNotifications
                              .notifications[
                                  futureNotifications.notifications.length -
                                      1 -
                                      index]
                              .body,
                          time: getTimeSince(futureNotifications
                              .notifications[
                                  futureNotifications.notifications.length -
                                      1 -
                                      index]
                              .date),
                          isRead: futureNotifications
                              .notifications[
                                  futureNotifications.notifications.length -
                                      1 -
                                      index]
                              .isRead,
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
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your notifications graphic or picture here
              Image(
                image: AssetImage('assets/images/no_notifications.png'),
                width: 300,
                height: 300,
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '¡No tenés notificaciones!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: SPColors.darkGray,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\n\n¡Aprovechá para descubrir restaurantes, te avisaremos cuando sea tu turno!',
                      style: TextStyle(
                        fontSize: 18,
                        color: SPColors.darkGray,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }

  String getTimeSince(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
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
