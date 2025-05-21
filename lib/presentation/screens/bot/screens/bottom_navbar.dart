import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/presentation/screens/book_a_ride/screens/book_a_ride_screen.dart';
import 'package:exodus/presentation/screens/bot/widgets/top_indicator.dart';
import 'package:exodus/presentation/screens/home/screens/home_screen.dart';
import 'package:exodus/presentation/screens/profile/screens/user_profile_screen.dart';
import 'package:exodus/presentation/screens/subscriptions/screens/subscriptions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar>
    with SingleTickerProviderStateMixin {
  final PageStorageBucket _bucket = PageStorageBucket();
  late TabController _tabController;

  // List of screens/pages that correspond to each bottom nav item
  final List<Widget> _screens = [
    const HomeScreen(),
    const BookARideScreen(),
    const SubscriptionScreen(),
    const UserProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: TabBarView(
          dragStartBehavior: DragStartBehavior.start,
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(), // Disable swipe
          children: _screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.secondary, // Use a contrasting color
              width: 0.2, // Thickness of the line
            ),
          ),
        ),
        child: Material(
          // color: AppColors.secondary,
          elevation: 8,
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
            indicator: const TopIndicator(),

            labelColor: AppColors.secondary,
            unselectedLabelColor: AppColors.secondary,
            tabs: const [
              Tab(icon: Icon(Icons.home_outlined), text: 'Home'),
              Tab(icon: Icon(Icons.directions_bus_outlined), text: 'Ride'),
              Tab(
                icon: Icon(Icons.subscriptions_outlined),
                text: 'Subscription',
              ),
              Tab(icon: Icon(Icons.person_outlined), text: 'My Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
