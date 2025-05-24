import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/presentation/theme/app_styles.dart';
import 'package:exodus/presentation/widgets/arrow_icon_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app/app_sizes.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/text_style.dart';
import '../../../widgets/app_scaffold.dart';
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Completed'),
              Tab(text: 'Canceled'),
            ],
          ),
        ),
        body: Padding(
          padding: AppSizes.paddingAllTiny,
          child: StreamBuilder<List<TicketModel>>(
            stream: _rideHistoryController.getAllRideHistoryListStream,
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
        return Padding(
          padding: AppSizes.paddingAllMedium,
          child: _buildRideCard(ride, isLastItem),
        );
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

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// [Soure] to [Destination] Ticket
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4, // Equivalent to Gap.w4
                runSpacing: 4, // Optional vertical spacing between lines
                children: [
                  Text(ride.source, style: AppText.h3),
                  ArrowIcon(),
                  Text(ride.destination, style: AppText.h3),
                ],
              ),
              // Text(
              //   '${ride.source} to ${ride.destination}',
              //   style: const TextStyle(
              //     color: AppColors.secondary,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16,
              //   ),
              // ),
              const Spacer(),
              Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 14),
                  const SizedBox(width: 4),
                  Text(ride.status, style: TextStyle(color: statusColor)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(ride.time, style: const TextStyle(color: AppColors.secondary)),
          const SizedBox(height: 4),
          Gap.h12,

          /// [Bus Name] Shuttle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Appple Red Bus", style: AppText.smallRegular)],
          ),
          if (!isLastItem)
            const Divider(height: 16, color: AppColors.secondary),
        ],
      ),
    );
  }
}
