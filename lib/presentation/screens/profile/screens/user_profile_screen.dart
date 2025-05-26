import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/app_state_service.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/string_extensions.dart';
import 'package:exodus/presentation/screens/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_scaffold.dart';
import '../../../widgets/custom_cached_image.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appStateService = sl<AppStateService>();
    final profileController = sl<ProfileController>();

    final user = appStateService.currentUser;

    return AppScaffold(
      appBar: AppBar(title: const Text("My Profile"), elevation: 0),
      body: Column(
        children: [
          if (user != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomCachedImage.avatarLarge(user.user.avatar.url),
                    Gap.w16,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.user.name.capitalizeFirstLetter(),
                          style: AppText.h1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.user.username.startsWithAt,
                          style: AppText.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: AppColors.secondary),
                ),
              ],
            ),
          ],

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                _buildMenuItem(
                  iconPath: "assets/icons/history.png",
                  title: "Ride History",
                  onTap: () {
                    NavigationService().sailTo(AppRoutes.rideHistory);
                  },
                ),
                _buildMenuItem(
                  iconPath: "assets/icons/password.png",
                  title: "Change Password",
                  onTap: () {
                    NavigationService().sailTo(AppRoutes.changePassword);
                  },
                ),
                _buildMenuItem(
                  iconPath: "assets/icons/about.png",
                  title: "About App",
                  onTap: () {
                    NavigationService().sailTo(AppRoutes.aboutApp);
                  },
                ),
                _buildMenuItem(
                  iconPath: "assets/icons/privacy.png",
                  title: "Privacy Policy",
                  onTap: () {
                    NavigationService().sailTo(AppRoutes.privacyPolicy);
                  },
                ),
                _buildMenuItem(
                  iconPath: "assets/icons/terms.png",
                  title: "Term & Condition",
                  onTap: () {
                    NavigationService().sailTo(AppRoutes.termsAndCondition);
                  },
                ),
                _buildMenuItem(
                  iconPath: "assets/icons/logout.png",
                  title: "Log Out",
                  onTap: () {
                    // Add logout logic here
                    profileController.logout();
                  },
                  isLogout: true,
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 50, // Fixed height of 50px
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    Image.asset(
                      iconPath,
                      width: 18,
                      height: 18,
                      color: isLogout ? AppColors.error : AppColors.secondary,
                    ),
                    Gap.w8,
                    Expanded(
                      child: Text(
                        title,
                        style: AppText.smallMedium.copyWith(
                          color:
                              isLogout ? AppColors.error : AppColors.secondary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: isLogout ? AppColors.error : AppColors.secondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Divider(height: 0.5, thickness: 1, color: AppColors.secondary),
        Gap.h8,
      ],
    );
  }

  // Widget _buildBottomNavigationBar() {
  //   return BottomNavigationBar(
  //     currentIndex: 3, // Profile tab is selected
  //     type: BottomNavigationBarType.fixed,
  //     selectedItemColor: AppColors.primary,
  //     unselectedItemColor: AppColors.grey,
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.directions_car),
  //         label: 'Book a Ride',
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.subscriptions),
  //         label: 'Subscription',
  //       ),
  //       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Profile'),
  //     ],
  //   );
  // }
}
