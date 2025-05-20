import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../widgets/app_scaffold.dart';

class BookARideScreen extends StatelessWidget {
  const BookARideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text("Book a Ride", style: AppText.h2),
        actions: [
          Container(
            width: 117,
            height: 37,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: AppColors.primaryGradient,
            ),
            child: Center(
              child: Text(
                "Reserve Bus",
                style: AppText.smallMedium.copyWith(
                  color: AppColors.background,
                ),
              ),
            ),
          ),
          Gap.w18,
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _locationSelect(),
              Gap.h24,
              _dateSelect(),
              Gap.h24,
              Text("Available Shuttles", style: AppText.h1),
              Gap.h16,
              _availableShuttles(),

              Gap.bottomAppBarGap,
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _locationSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: AppColors.secondary,
            ),
            Gap.w8,
            Text("From", style: AppText.bodyRegular),
          ],
        ),
        Gap.h16,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: AppColors.secondary),
              Gap.w8,
              Text("Any location", style: AppText.bodyRegular),
            ],
          ),
        ),
        Gap.h16,
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: AppColors.secondary,
            ),
            Gap.w8,
            Text("To", style: AppText.bodyRegular),
          ],
        ),
        Gap.h8,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [Text("Any location", style: AppText.bodyRegular)],
          ),
        ),
      ],
    );
  }

  Widget _dateSelect() {
    final dates = DateUtilsForThirtyDays.getFormattedNextDays();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Date", style: AppText.smallRegular),
        Gap.h8,
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (context, index) => Gap.w8,
            itemBuilder: (context, index) {
              final isToday = index == 0;
              return Container(
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isToday ? AppColors.primary : AppColors.secondary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isToday ? AppColors.primary.withOpacity(0.1) : null,
                ),
                child: Center(
                  child: Text(
                    dates[index],
                    style: AppText.smallRegular.copyWith(
                      color: isToday ? AppColors.primary : null,
                      fontWeight: isToday ? FontWeight.bold : null,
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

  Widget _availableShuttles() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (context, index) => Gap.h16,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("West Bay to Al Wakra", style: AppText.smallMedium),
                Gap.h8,
                Text("08:30am - 09:15am", style: AppText.smallRegular),
                Gap.h8,
                Text("7 seats left", style: AppText.smallRegular),
                Gap.h16,
                Row(
                  children: [
                    Icon(Icons.star, color: AppColors.primary, size: 16),
                    Text("West Bay", style: AppText.smallRegular),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    Icon(Icons.star, color: AppColors.primary, size: 16),
                    Text("Al Wakra", style: AppText.smallRegular),
                  ],
                ),
                Gap.h16,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Book",
                      style: AppText.smallMedium.copyWith(
                        color: AppColors.background,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.directions_bus, color: AppColors.primary),
              onPressed: () {},
            ),
            IconButton(icon: Icon(Icons.subscriptions), onPressed: () {}),
            IconButton(icon: Icon(Icons.person), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
