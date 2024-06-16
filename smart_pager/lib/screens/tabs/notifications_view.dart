import 'package:flutter/material.dart';
import 'package:smart_pager/config/cellules/cards/notification_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NotificationCard(
                    title: "tu mesa está lista",
                    description: "Anunciate en puerta con tu nombre",
                    time: "Hace 5 minutos",
                    isRead: false,
                  ),
                  SizedBox(height: 10),
                  NotificationCard(
                    title: "tu mesa está lista",
                    description: "Anunciate en puerta con tu nombre",
                    time: "Hace 5 minutos",
                    isRead: true,
                  ),
                  SizedBox(height: 10),
                  NotificationCard(
                    title: "tu mesa está lista",
                    description: "Anunciate en puerta con tu nombre",
                    time: "Hace 5 minutos",
                    isRead: true,
                  ),
                  SizedBox(height: 10),
                  NotificationCard(
                    title: "tu mesa está lista",
                    description: "Anunciate en puerta con tu nombre",
                    time: "Hace 5 minutos",
                    isRead: true,
                  ),
                  SizedBox(height: 10),
                  NotificationCard(
                    title: "tu mesa está lista",
                    description: "Anunciate en puerta con tu nombre",
                    time: "Hace 5 minutos",
                    isRead: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
