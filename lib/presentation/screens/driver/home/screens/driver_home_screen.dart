import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/string_extensions.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/presentation/screens/home/controller/home_controller.dart';
import 'package:exodus/presentation/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
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
    return Scaffold(appBar: _buildAppBar());
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
                onTap: () {
                  NavigationService().sailTo(AppRoutes.notification);
                },
              ),
              SizedBox(width: 18.0),
            ],
          );
        },
      ),
    );
  }
}
