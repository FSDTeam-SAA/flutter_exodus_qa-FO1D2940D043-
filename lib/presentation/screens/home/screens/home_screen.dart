import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/string_extensions.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/data/models/ticket/ticket_model.dart';
import 'package:exodus/presentation/screens/home/controller/home_controller.dart';
import 'package:exodus/presentation/theme/app_styles.dart';
import 'package:exodus/presentation/widgets/arrow_icon_widget.dart';
import 'package:exodus/presentation/widgets/build_title.dart';
import 'package:exodus/presentation/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = sl<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller.getUserData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Get screen dimensions
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 600;

          return ValueListenableBuilder<UserData?>(
            valueListenable: _controller.userDataNotifier,

            builder: (context, value, _) {
              if (value == null) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 0 : screenWidth * 0.1,
                  vertical: 16.0,
                ),
                children: [
                  // _buildHeader(value.user),
                  Gap.h16,
                  _buildRideLeftRewardPoints(),

                  Gap.h40,
                  TitleTextWidget(title: "Your Next Ride"),

                  Gap.h16,
                  _buildNextRideCard(value.ticket),

                  Gap.h22,
                  TitleTextWidget(title: "Your All Ride"),

                  Gap.h16,
                  _buildAllRidesList(),

                  Gap.bottomAppBarGap,
                ],
              );
            },
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: ValueListenableBuilder<UserData?>(
        valueListenable: _controller.userDataNotifier,
        builder: (context, userData, _) {
          return AppBar(
            leadingWidth: 60.0,
            leading: Row(
              children: [
                SizedBox(width: 18.0),
                SizedBox(
                  child: CustomCachedImage.avatarSmall(
                    userData?.user.avatar.url ?? '',
                  ),
                ),
              ],
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData?.user.name.capitalizeFirstOfEach ?? 'User Name',
                  style: AppText.bodySemiBold.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                Text(
                  userData?.user.username.startsWithAt ?? "@username",
                  style: AppText.smallRegular,
                ),
              ],
            ),
            actions: [
              InkWell(
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: AppColors.secondary,
                ),
                onTap: () {},
              ),
              SizedBox(width: 18.0),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRideLeftRewardPoints() {
    return Padding(
      padding: AppSizes.paddingHorizontalExtraMedium,
      child: Row(
        children: [
          Expanded(child: _buildStatsCard("Ride Left", "4")),
          Gap.w16,
          Expanded(child: _buildStatsCard("Reward Points", "120")),
        ],
      ),
    );
  }

  // Widget _buildHeader(User user) {
  //   dPrint("user Image -> ${user.avatar.url}");
  //   return Padding(
  //     padding: AppSizes.paddingHorizontalExtraMedium,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // CustomCachedImage.avatarSmall(user.avatar.url),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text("Hello, ${user.name}"),
  //               SizedBox(height: 4),
  //               Text("@${user.username}", style: TextStyle()),
  //             ],
  //           ),
  //         ),
  //         Icon(
  //           Icons.notifications_none_outlined,
  //           color: AppColors.secondary,
  //           size: 28,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildTitle(String title) {
  //   return Padding(
  //     padding: AppSizes.paddingHorizontalExtraMedium,
  //     child: Text(title, style: AppText.bodySemiBold),
  //   );
  // }

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
            color: AppColors.background,
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

    return GestureDetector(
      onTap:
          () => Navigator.pushNamed(
            context,
            AppRoutes.rideDetails,
            arguments: {'Tickets': tickets},
          ),
      child: Padding(
        padding: AppSizes.paddingHorizontalExtraMedium,
        child: Container(
          decoration: AppDecorations.card,
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
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              nextTicket.source,
                              style: AppText.h3.copyWith(
                                color: AppColors.background,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap.w4,

                            /// [Arrow] Icon
                            ArrowIcon(color: AppColors.background),

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
                    _rideInfoRow(
                      Icons.event_seat,
                      "Seat",
                      nextTicket.seatNumber,
                    ),
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
        text.capitalizeFirstLetter(),
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
      padding: AppSizes.paddingHorizontalExtraMedium,
      child: Container(
        decoration: AppDecorations.card,

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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ride['time']!,
                                      style: const TextStyle(
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                    Text(
                                      ride['seats']!,
                                      style: const TextStyle(
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
