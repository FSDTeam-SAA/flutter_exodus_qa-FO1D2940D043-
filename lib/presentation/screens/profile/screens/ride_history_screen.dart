import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/presentation/screens/profile/controllers/ride_history_controller.dart';
import 'package:exodus/presentation/theme/app_styles.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  final _rideHistoryController = sl<RideHistoryController>();
  late Future<List<TicketModel>> _loadRideHistory;

  @override
  void initState() {
    super.initState();
    _loadRideHistory = _rideHistoryController.getAllRideHistory();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('Ride History')),
      body: Padding(
        padding: AppSizes.paddingAllMedium,
        child: FutureBuilder<List<TicketModel>>(
          future: _loadRideHistory,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final rides = snapshot.data ?? <TicketModel>[];

            if (rides.isEmpty) {
              return const Center(child: Text('No ride history available.'));
            }

            return ListView.builder(
              itemCount: rides.length,
              itemBuilder: (context, index) {
                final ride = rides[index];
                final isLastItem = index == rides.length - 1;
                return _buildRideCard(ride, isLastItem);
              },
            );
          },
          // ),
        ),
      ),
    );
  }

  Widget _buildRideCard(TicketModel ride, bool isLastItem) {
    Color statusColor;
    IconData statusIcon;
    String statusText = ride.status;

    switch (ride.status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'canceled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.blue;
        statusIcon = Icons.access_time;
    }

    ///`?` [Todo] Fix the issue for the color and UI
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: AppSizes.paddingAllMedium,
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${ride.source} to ${ride.destination}",
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(statusIcon, size: 16, color: statusColor),
                  const SizedBox(width: 4),
                  Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(ride.time, style: const TextStyle(color: AppColors.secondary)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 4),
              Text(
                "${ride.source}  ↔  ${ride.destination}",
                style: const TextStyle(color: AppColors.secondary),
              ),
            ],
          ),
          if (!isLastItem) ...[
            const SizedBox(height: 12),
            Divider(color: AppColors.secondary.withOpacity(0.3)),
          ],
        ],
      ),
    );
  }
}
