import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/date_utils.dart';
import 'package:exodus/presentation/screens/notification/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _notificationController = sl<NotificationController>();
  late Future<void> _loadNotifications;

  @override
  void initState() {
    super.initState();
    _loadNotifications = _notificationController.getAllNotifications();
  }

  String _formatFullDateTime(DateTime date) {
    final datePart = DateFormat(
      'MMM d, yyyy',
    ).format(date); // e.g., May 21, 2025
    final timePart = DateUtilsForThirtyDays.formatTime(date); // e.g., 2:45pm
    return '$timePart • $datePart';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: FutureBuilder<void>(
        future: _loadNotifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_notificationController.notifications.isEmpty) {
            return const Center(child: Text('No notifications yet!'));
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _notificationController.notifications.length,
            itemBuilder: (context, index) {
              final notification = _notificationController.notifications[index];
              final isLastItem =
                  index == _notificationController.notifications.length - 1;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.secondary,
                      child: Icon(
                        Icons.notifications,
                        color: AppColors.background,
                      ),
                    ),
                    title: Text(
                      notification.message,
                      maxLines: 2,
                      style: AppText.smallRegular,
                    ),
                    subtitle: Text(
                      _formatFullDateTime(notification.createdAt),
                      style: AppText.smallRegular.copyWith(
                        color: AppColors.textSecondary.withAlpha(150),
                      ),
                    ),
                  ),
                  Gap.h16,
                  if (!isLastItem) // Only add divider if not the last item
                    Divider(
                      color: AppColors.secondary,
                      height: 16, // Adjust height as needed
                      thickness: 1,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
