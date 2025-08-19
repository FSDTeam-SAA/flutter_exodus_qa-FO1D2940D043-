import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Assuming these imports exist in your project
import '../../../../core/constants/app/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/date_utils.dart';
import '../controllers/hour_selector_controller.dart';
import '../widgets/hour_selector.dart';

import 'package:intl/intl.dart';

class ReserveBusScreen extends StatefulWidget {
  const ReserveBusScreen({super.key});

  @override
  State<ReserveBusScreen> createState() => _ReserveBusScreenState();
}

class _ReserveBusScreenState extends State<ReserveBusScreen> {
  final HourSelectorController hourController = HourSelectorController();
  final ValueNotifier<TimeOfDay?> _selectedTimeNotifier = ValueNotifier(null);
  final ValueNotifier<DateTime?> _selectedDateNotifier = ValueNotifier(null);
  final ValueNotifier<int> _selectedDateIndexNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    // Initialize with current time rounded to nearest 30 minutes
    final now = TimeOfDay.now();
    final minute = now.minute < 30 ? 0 : 30;
    _selectedTimeNotifier.value = TimeOfDay(hour: now.hour, minute: minute);
    _selectedDateNotifier.value = DateTime.now();
  }

  @override
  void dispose() {
    hourController.dispose();
    _selectedTimeNotifier.dispose();
    _selectedDateNotifier.dispose();
    _selectedDateIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reserve Bus")),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          _buildTimeSelector(),
          const SizedBox(height: 16),
          _buildDateSelector(),
          const SizedBox(height: 16),
          HourSelector(controller: hourController),
          const SizedBox(height: 24),
          _buildReserveButton(context),
        ],
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, size: 16, color: AppColors.secondary),
            const SizedBox(width: 8),
            Text("Select Time", style: AppText.smallRegular),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 70, // Increased height for animation
          child: ValueListenableBuilder<TimeOfDay?>(
            valueListenable: _selectedTimeNotifier,
            builder: (context, selectedTime, _) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 34, // From 6:00 to 22:00 in 30-min increments
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final hour = 6 + (index ~/ 2);
                  final minute = (index % 2) * 30;
                  final time = TimeOfDay(hour: hour, minute: minute);
                  final isSelected =
                      selectedTime?.hour == hour &&
                      selectedTime?.minute == minute;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: isSelected ? 65 : 60, // Wider when selected
                    height: 60,
                    child: GestureDetector(
                      onTap: () => _selectedTimeNotifier.value = time,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              isSelected
                                  ? AppColors.secondary
                                  : AppColors.secondary.withAlpha(
                                    (0.2 * 255).toInt(),
                                  ),
                          boxShadow:
                              isSelected
                                  ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                  : null,
                        ),
                        child: Center(
                          child: Text(
                            _formatTime(time),
                            style: AppText.smallRegular.copyWith(
                              color:
                                  isSelected
                                      ? AppColors.background
                                      : AppColors.secondary,
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    final dates = DateUtilsForThirtyDays.getFormattedNextDays();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, size: 16, color: AppColors.secondary),
            const SizedBox(width: 8),
            Text("Select Date", style: AppText.smallRegular),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 70, // Increased height for animation
          child: ValueListenableBuilder<int>(
            valueListenable: _selectedDateIndexNotifier,
            builder: (context, selectedIndex, _) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: isSelected ? 65 : 60, // Wider when selected
                    height: 60,

                    child: GestureDetector(
                      onTap: () {
                        _selectedDateIndexNotifier.value = index;
                        _selectedDateNotifier.value = DateTime.now().add(
                          Duration(days: index),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              isSelected
                                  ? AppColors.secondary
                                  : AppColors.secondary.withAlpha(
                                    (0.2 * 255).toInt(),
                                  ),
                          boxShadow:
                              isSelected
                                  ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                  : null,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dates[index]['day']!,
                                style: AppText.smallRegular.copyWith(
                                  color:
                                      isSelected
                                          ? AppColors.background
                                          : AppColors.secondary,
                                ),
                              ),
                              Text(
                                dates[index]['date']!,
                                style: AppText.h2.copyWith(
                                  color:
                                      isSelected
                                          ? AppColors.background
                                          : AppColors.secondary,
                                  fontWeight:
                                      isSelected ? FontWeight.bold : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReserveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: context.primaryButton(
        onPressed: () => _showReservationDetails(context),
        text: "Book Request",
      ),
    );
  }

  void _showReservationDetails(BuildContext context) {
    if (_selectedTimeNotifier.value == null ||
        _selectedDateNotifier.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select time and date')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return ValueListenableBuilder3<TimeOfDay?, DateTime?, int>(
          valueListenable1: _selectedTimeNotifier,
          valueListenable2: _selectedDateNotifier,
          valueListenable3: _selectedDateIndexNotifier,
          builder: (context, time, date, index, _) {
            return AlertDialog(
              title: const Text('Reservation Summary'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${DateFormat('EEE, MMM d').format(date!)}'),
                  Text('Time: ${_formatTime(time!)}'),
                  Text(
                    'Duration: ${hourController.hours.toStringAsFixed(1)} hours',
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Subtotal: \$${hourController.subtotal.toStringAsFixed(2)}',
                  ),
                  Text('Tax: \$${hourController.tax.toStringAsFixed(2)}'),
                  const Divider(),
                  Text(
                    'Total: \$${hourController.total.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => NavigationService().backtrack(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    NavigationService().backtrack();

                    
                    
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Reservation confirmed!')),
                    // );
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

// Helper class to listen to multiple ValueNotifiers
class ValueListenableBuilder3<A, B, C> extends StatelessWidget {
  final ValueListenable<A> valueListenable1;
  final ValueListenable<B> valueListenable2;
  final ValueListenable<C> valueListenable3;
  final Widget Function(BuildContext context, A a, B b, C c, Widget? child)
  builder;
  final Widget? child;

  const ValueListenableBuilder3({
    required this.valueListenable1,
    required this.valueListenable2,
    required this.valueListenable3,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: valueListenable1,
      builder: (_, a, __) {
        return ValueListenableBuilder<B>(
          valueListenable: valueListenable2,
          builder: (_, b, __) {
            return ValueListenableBuilder<C>(
              valueListenable: valueListenable3,
              builder: (context, c, __) {
                return builder(context, a, b, c, child);
              },
            );
          },
        );
      },
    );
  }
}
