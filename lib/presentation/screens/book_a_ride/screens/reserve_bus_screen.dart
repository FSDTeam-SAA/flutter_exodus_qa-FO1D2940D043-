import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app/app_colors.dart';
import '../../../../core/constants/app/app_gap.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/date_utils.dart';
import '../controllers/hour_selector_controller.dart';
import '../widgets/hour_selector.dart';

class ReserveBusScreen extends StatefulWidget {
  const ReserveBusScreen({super.key});

  @override
  State<ReserveBusScreen> createState() => _ReserveBusScreenState();
}

class _ReserveBusScreenState extends State<ReserveBusScreen> {
  @override
  Widget build(BuildContext context) {
    final HourSelectorController hourController = HourSelectorController();

    TimeOfDay? _selectedTime;
    DateTime? _selectedDate;
    int _selectedDateIndex = 0;

    return AppScaffold(
      appBar: AppBar(title: const Text("Reserve Bus")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  _timeSelect(
                    selectedTime: _selectedTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _selectedTime = time;
                      });
                    },
                  ),
                  Gap.h16,
                  _dateSelect(),
                  Gap.h16,
                  HourSelector(controller: hourController),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _timeSelect({
    required TimeOfDay? selectedTime,
    required Function(TimeOfDay) onTimeSelected,
  }) {
    // Generate time slots from 6:00 AM to 10:00 PM in 30-minute increments
    final times = List.generate(34, (index) {
      final hour = 6 + (index ~/ 2);
      final minute = (index % 2) * 30;
      return TimeOfDay(hour: hour, minute: minute);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time_outlined,
              size: 16,
              color: AppColors.secondary,
            ),
            Gap.w8,
            Text("Select Time", style: AppText.smallRegular),
          ],
        ),
        Gap.h8,
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            separatorBuilder: (context, index) => Gap.w8,
            itemBuilder: (context, index) {
              final time = times[index];
              final isSelected =
                  selectedTime?.hour == time.hour &&
                  selectedTime?.minute == time.minute;

              return GestureDetector(
                onTap: () => onTimeSelected(time),
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected ? AppColors.primary : AppColors.secondary,
                    border:
                        isSelected
                            ? Border.all(color: AppColors.primaryDark, width: 2)
                            : null,
                  ),
                  child: Center(
                    child: Text(
                      _formatTime(time),
                      style: AppText.smallRegular.copyWith(
                        color:
                            isSelected
                                ? AppColors.background
                                : AppColors.background,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute =
        time.minute == 0 ? '' : ':${time.minute.toString().padLeft(2, '0')}';
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour$minute $period';
  }

  Widget _dateSelect() {
    final dates = DateUtilsForThirtyDays.getFormattedNextDays();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: AppColors.secondary,
            ),
            Gap.w8,
            Text("Select Date", style: AppText.smallRegular),
          ],
        ),
        Gap.h8,
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (context, index) => Gap.w8,
            itemBuilder: (context, index) {
              final isToday = index == 0;
              return Container(
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isToday ? AppColors.secondary : AppColors.secondary,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dates[index]['day']!,

                        style: AppText.smallRegular.copyWith(
                          color: AppColors.background,
                        ),
                      ),
                      Text(
                        dates[index]['date']!,

                        style: AppText.h2.copyWith(color: AppColors.background),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.background),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: AppColors.background),
      ),
    );
  }

  Widget _priceRow(String label, double value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: bold ? AppText.h3 : AppText.smallRegular),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style:
              bold
                  ? AppText.h3.copyWith(fontWeight: FontWeight.bold)
                  : AppText.smallRegular,
        ),
      ],
    );
  }

  Widget _subscriptionToggle() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.radio_button_unchecked,
            color: AppColors.secondary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text("With Subscription", style: AppText.smallRegular),
        ],
      ),
    );
  }

  Widget _bookButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle booking action here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text("Book Request"),
      ),
    );
  }
}
