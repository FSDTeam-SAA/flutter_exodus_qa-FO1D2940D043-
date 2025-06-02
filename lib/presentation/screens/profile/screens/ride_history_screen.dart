import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/presentation/core/services/app_data_store.dart';
import 'package:exodus/presentation/theme/app_styles.dart';
import 'package:exodus/presentation/widgets/arrow_icon_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app/app_sizes.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/text_style.dart';
import '../controllers/ride_history_controller.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  final _rideHistoryController = sl<RideHistoryController>();

  @override
  void initState() {
    super.initState();
    _rideHistoryController.getAllRideHistory();
  }

  @override
  void dispose() {
    _rideHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ride History'),
          bottom: TabBar(
            dividerColor: AppColors.secondary,
            indicatorColor: AppColors.secondary,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.secondary,
            indicatorWeight: 2,
            unselectedLabelColor: AppColors.secondary,

            // labelStyle: AppText.,
            // unselectedLabelStyle: AppText.h4,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
        body: Padding(
          padding: AppSizes.paddingAllExtraMedium,
          child: Container(
            decoration: AppDecorations.card,
            child: StreamBuilder<List<TicketModel>>(
              stream: AppDataStore().rideHistoryStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final rides = snapshot.data ?? [];

                return TabBarView(
                  children: [
                    _buildRideList(rides), // All
                    _buildRideList(
                      rides
                          .where((r) => r.status.toLowerCase() == 'completed')
                          .toList(),
                    ),
                    _buildRideList(
                      rides
                          .where((r) => r.status.toLowerCase() == 'canceled')
                          .toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRideList(List<TicketModel> rides) {
    if (rides.isEmpty) {
      return const Center(child: Text('No rides found.'));
    }

    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        final isLastItem = index == rides.length - 1;
        return _buildRideCard(ride, isLastItem);
      },
    );
  }

  Widget _buildRideCard(TicketModel ride, bool isLastItem) {
  Color statusColor;
  IconData statusIcon;

  switch (ride.status.toLowerCase()) {
    case 'completed':
      statusColor = AppColors.success;
      statusIcon = Icons.check_circle;
      break;
    case 'canceled':
      statusColor = AppColors.error;
      statusIcon = Icons.cancel;
      break;
    default:
      statusColor = Colors.blue;
      statusIcon = Icons.access_time;
  }

  return Column(
    children: [
      Padding(
        padding: AppSizes.paddingAllMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Source -> Destination with status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Source -> Destination
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(ride.source, style: AppText.h3),
                    const ArrowIcon(),
                    Text(ride.destination, style: AppText.h3),
                  ],
                ),
                // Status indicator
                Row(
                  children: [
                    Icon(statusIcon, color: statusColor, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      ride.status,
                      style: TextStyle(color: statusColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Time and Bus Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ride.time, 
                  style: const TextStyle(color: AppColors.secondary)),
                const SizedBox(height: 8),
                Text("Apple Red Bus", 
                  style: AppText.smallRegular),
              ],
            ),
          ],
        ),
      ),
      
      // Divider if not last item
      if (!isLastItem) 
        const Divider(height: 1, color: AppColors.secondary),
    ],
  );
}
}
