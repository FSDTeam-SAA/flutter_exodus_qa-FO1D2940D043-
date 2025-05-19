import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/data/models/auth/register_response.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/presentation/screens/auth/controllers/login_controller.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:exodus/presentation/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = sl<LoginController>();

  @override
  void initState() {
    super.initState();
    _controller.getUserData();
  }

  @override
  void dispose() {
    _controller.dispose(); // Close the stream when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<UserData?>(
        valueListenable: _controller.userDataNotifier,

        builder: (context, value, _) {
          if (value == null) return Center(child: CircularProgressIndicator());
          return ListView(
            children: [
              _buildHeader(value.user),

              Gap.h16,
              _buildRideLeftRewardPoints(),

              Gap.h40,
              _buildTitle("Your Next Ride"),

              Gap.h16,
              _buildNextRideCard(value.ticket),

              Gap.h22,
              _buildTitle("Your All Ride"),

              Gap.h16,
              _buildAllRidesList(),
            ],
          );
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("Home ${value.user.email}"),
          //       Gap.h12,
          //       context.primaryButton(
          //         onPressed: () async {
          //           await _controller.getUserData();
          //         },
          //         text: "Get Data",
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }

  Widget _buildRideLeftRewardPoints() {
    return Padding(
      padding: AppSizes.paddingHorizontalMedium,
      child: Row(
        children: [
          Expanded(child: _buildStatsCard("Ride Left", "4")),
          Gap.w16,
          Expanded(child: _buildStatsCard("Reward Points", "120")),
        ],
      ),
    );
  }

  Widget _buildHeader(User user) {
    dPrint("user Image -> ${user.avatar.url}");
    return Padding(
      padding: AppSizes.paddingHorizontalMedium,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CustomCachedImage.avatarSmall(user.avatar.url),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello, ${user.name}"),
                SizedBox(height: 4),
                Text("@${user.username}", style: TextStyle()),
              ],
            ),
          ),
          Icon(
            Icons.notifications_none_outlined,
            color: AppColors.secondary,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: AppSizes.paddingHorizontalMedium,
      child: Text(title, style: AppText.bodySemiBold),
    );
  }

  Widget _buildStatsCard(String title, String value) {
    return Container(
      padding: AppSizes.paddingAllRegular,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: AppSizes.borderRadiusMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppText.h3.copyWith(color: AppColors.buttonText)),
          Gap.h4,
          Text(value, style: AppText.h1.copyWith(color: AppColors.buttonText)),
        ],
      ),
    );
  }

  Widget _buildNextRideCard(List<Ticket> tickets) {
    // Find the next upcoming ticket (you might want to add proper logic here)
    final nextTicket = tickets.isNotEmpty ? tickets.first : null;

    if (nextTicket == null) {
      return Padding(
        padding: AppSizes.paddingAllRegular,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: AppSizes.borderRadiusMedium,
          ),
          padding: AppSizes.paddingAllRegular,
          child: const Center(
            child: Text(
              "No upcoming rides",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: AppSizes.paddingHorizontalMedium,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: AppSizes.borderRadiusMedium,

          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: AppSizes.paddingAllRegular,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// [Soure] to [Destination] Ticket
                  Row(
                    children: [
                      Text(
                        nextTicket.source,
                        style: AppText.h3.copyWith(
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap.w4,
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.background,
                        size: 20,
                      ),
                      Gap.w4,
                      Text(
                        nextTicket.destination,
                        style: AppText.h3.copyWith(
                          color: AppColors.background,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  /// [Date]
                  Text(
                    DateFormat(
                      'EEE, MMM d',
                    ).format(DateTime.parse(nextTicket.date)),
                    style: AppText.bodySemiBold.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: AppSizes.paddingAllRegular,
              child: Column(
                children: [
                  // Gap.h12,
                  _rideInfoRow(
                    Icons.directions_bus,
                    "Bus",
                    nextTicket.busNumber,
                  ),
                  Gap.h16,
                  _rideInfoRow(Icons.event_seat, "Seat", nextTicket.seatNumber),
                  Gap.h16,
                  _rideInfoRow(Icons.access_time, "Time", nextTicket.time),
                  // if (nextTicket.qrCode.isNotEmpty) ...[
                  //   const SizedBox(height: 12),
                  //   Center(
                  //     child: Image.network(nextTicket.qrCode, height: 100, width: 100),
                  //   ),
                  // ],
                  Gap.h24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _goldButton(nextTicket.status),
                      Row(
                        children: [
                          Text("View Details", style: AppText.smallRegular),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.secondary,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rideInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.secondary, size: 20),
        Gap.w8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppText.smallRegular),
            Text(value, style: AppText.bodyMedium),
          ],
        ),
      ],
    );
  }

  Widget _goldButton(String text) {
    return Container(
      padding: AppSizes.paddingAllSmall,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: AppColors.primaryGradient,
      ),
      child: Text(
        text[0].toUpperCase() + text.substring(1),
        style: AppText.tinyRegular.copyWith(color: AppColors.background),
      ),
    );
  }

  Widget _buildAllRidesList() {
    final rides = List.generate(
      4,
      (index) => {
        'route': 'West Bay to Al Wakra',
        'time': '08:30am - 09:15am',
        'seats': '7 seats left',
      },
    );

    return Padding(
      padding: AppSizes.paddingHorizontalMedium,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: AppSizes.borderRadiusMedium,
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children:
              rides.asMap().entries.map((entry) {
                final index = entry.key;
                final ride = entry.value;
                final isLastItem = index == rides.length - 1;

                return Column(
                  children: [
                    Padding(
                      padding: AppSizes.paddingAllMedium,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ride['route']!,
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ride['time']!,
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            ride['seats']!,
                            style: const TextStyle(color: AppColors.secondary),
                          ),
                        ],
                      ),
                    ),
                    if (!isLastItem) // Only add divider if not the last item
                      Divider(
                        color: AppColors.secondary,
                        height: 16, // Adjust height as needed
                        thickness: 1,
                      ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
