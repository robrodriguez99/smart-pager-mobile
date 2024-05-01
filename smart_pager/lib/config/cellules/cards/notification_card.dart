import 'package:flutter/material.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class NotificationCard extends StatelessWidget {
  final String? title, description, time;
  final bool? isRead;

  const NotificationCard(
      {super.key, this.title, this.description, this.time, this.isRead});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Do something
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
                  text: title!,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            
            const SizedBox(height: 5),
            CustomText(
              text: description!,
              fontSize: 16,
              color: Colors.grey,
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