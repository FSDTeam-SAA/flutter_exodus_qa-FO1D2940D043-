import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/presentation/screens/book_a_ride/controllers/create_ticket_controller.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:exodus/data/models/bus/single_bus_response.dart';

class SeatsScreen extends StatefulWidget {
  final BusDetailResponse seates;
  final String source;
  final String destination;
  final DateTime date;
  const SeatsScreen({
    super.key,
    required this.seates,
    required this.source,
    required this.destination,
    required this.date,
  });

  @override
  State<SeatsScreen> createState() => _SeatsScreenState();
}

class _SeatsScreenState extends State<SeatsScreen> {
  final ValueNotifier<String?> _selectedSeat = ValueNotifier<String?>(null);
  final ValueNotifier<bool> _showStandingOption = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _standingApplied = ValueNotifier<bool>(false);

  final _createTicketController = sl<CreateTicketController>();

  @override
  void initState() {
    super.initState();
    // Check if all seats are taken to show standing option
    _showStandingOption.value =
        widget.seates.availableSeats.isEmpty &&
        widget.seates.totalSeats.isNotEmpty;
  }

  Future<void> _handleSubmission() async {
    // _isLoading.value = true;

    try {
      if (_selectedSeat.value != null) {
        // Create seated ticket
        await _createTicketController.createTicket(
          _selectedSeat.value!,
          widget.seates.bus.id,
          widget.source,
          widget.destination,
          widget.date,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Seat ${_selectedSeat.value} booked successfully'),
          ),
        );
      } else if (_standingApplied.value) {
        // Create standing ticket
        // await _createTicketController.createStandingTicket(
        //   widget.seates.bus.busNumber,
        //   widget.source,
        //   widget.destination,
        //   widget.date,
        // );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Standing ticket requested successfully'),
          ),
        );
      }

      // Navigate back or to next screen
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      // _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bus = widget.seates.bus;
    final availableSeats = widget.seates.availableSeats;
    final totalSeats = widget.seates.totalSeats;

    // Group seats by row
    final Map<String, List<String>> seatRows = {};
    for (final seat in totalSeats) {
      final row = seat.substring(0, 1); // Get the letter part (A, B, C, etc.)
      seatRows.putIfAbsent(row, () => []).add(seat);
    }

    return AppScaffold(
      appBar: AppBar(title: const Text('Select Seat')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Seat grid
          Expanded(
            child: ListView.builder(
              itemCount: seatRows.length,
              itemBuilder: (context, rowIndex) {
                final rowKey = seatRows.keys.elementAt(rowIndex);
                final rowSeats = seatRows[rowKey]!;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // First pair of seats
                      for (int i = 0; i < 2; i++)
                        if (i < rowSeats.length)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: _buildSeatWidget(
                              rowSeats[i],
                              availableSeats.contains(rowSeats[i]),
                            ),
                          ), // Spacer between pairs
                      Spacer(), // Second pair of seats
                      for (int i = 2; i < 4; i++)
                        if (i < rowSeats.length)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: _buildSeatWidget(
                              rowSeats[i],
                              availableSeats.contains(rowSeats[i]),
                            ),
                          ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// [Submit] button
          ValueListenableBuilder<Object>(
            valueListenable: ValueNotifier<Object>([
              _selectedSeat.value,
              _standingApplied.value,
            ]),
            builder: (context, _, __) {
              final isEnabled =
                  _selectedSeat.value != null || _standingApplied.value;

              return context.primaryButton(
                width: 130,
                text: "Submit",
                onPressed: () {
                  _handleSubmission();
                  // _createTicketController.createTicket(
                  //   seatNumber,
                  //   busNumber,
                  //   source,
                  //   destination,
                  //   date,
                  // );
                },
              );
            },
          ),

          // Standing option
          ValueListenableBuilder<bool>(
            valueListenable: _showStandingOption,
            builder: (context, showStanding, _) {
              // if (!showStanding) return const SizedBox();

              return _cancellationPolicy(context);

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       'Standing',
              //       style: AppText.h3.copyWith(fontWeight: FontWeight.bold),
              //     ),
              //     const SizedBox(height: 4),
              //     Text(
              //       'Note: When all seats are full, a limited number of users can request standing tickets. The bus driver will be notified, and upon approval, the user will be granted access for standing travel.',
              //       style: AppText.bodyExtraLarg,
              //     ),
              //     const SizedBox(height: 8),
              //     ValueListenableBuilder<bool>(
              //       valueListenable: _standingApplied,
              //       builder: (context, standingApplied, _) {
              //         return ElevatedButton(
              //           onPressed:
              //               standingApplied
              //                   ? null
              //                   : () {
              //                     _standingApplied.value = true;
              //                     _selectedSeat.value = null;
              //                   },
              //           child: Text(
              //             standingApplied
              //                 ? 'Standing Applied'
              //                 : 'Apply for standing',
              //             style: AppText.bodyExtraLarg,
              //           ),
              //         );
              //       },
              //     ),
              //     const SizedBox(height: 16),
              //   ],
              // );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSeatWidget(String seatNumber, bool isAvailable) {
    return ValueListenableBuilder<String?>(
      valueListenable: _selectedSeat,
      builder: (context, selectedSeat, _) {
        return SeatWidget(
          seatNumber: seatNumber,
          isAvailable: isAvailable,
          isSelected: selectedSeat == seatNumber,
          onTap:
              isAvailable
                  ? () {
                    _selectedSeat.value = seatNumber;
                    _standingApplied.value = false;
                  }
                  : null,
        );
      },
    );
  }

  Widget _cancellationPolicy(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerPolicyColor,
        borderRadius: AppSizes.borderRadiusMedium,
      ),
      child: Padding(
        padding: AppSizes.paddingAllMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// [Title]
            Text("Standing", style: AppText.bodyMedium),

            Gap.h8,
            Text(
              "Note: When all seats are full, a limited number of users can request standing tickets. The bus driver will be notified, and upon approval, the user will be granted access for standing travel.",
            ),

            Gap.h16,
            context.secondaryButton(
              onPressed: () {},
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback:
                        (bounds) =>
                            AppColors.primaryGradient.createShader(bounds),
                    child: Text(
                      "Apply for standing",
                      style: AppText.smallMedium.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _selectedSeat.dispose();
    _showStandingOption.dispose();
    _standingApplied.dispose();
    super.dispose();
  }
}

class SeatWidget extends StatelessWidget {
  final String seatNumber;
  final bool isAvailable;
  final bool isSelected;
  final VoidCallback? onTap;

  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.isAvailable,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (isSelected) {
      backgroundColor = AppColors.secondary.withAlpha((0.4 * 255).toInt());
    } else if (isAvailable) {
      backgroundColor = AppColors.secondary;
    } else {
      backgroundColor = AppColors.background;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.secondary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            seatNumber,
            style: AppText.h2.copyWith(color: AppColors.background),
          ),
        ),
      ),
    );
  }
}
