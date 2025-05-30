import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/services/app_state_service.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/core/utils/extensions/input_decoration_extensions.dart';
import 'package:exodus/presentation/screens/profile/controllers/profile_controller.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_cached_image.dart';
import '../../auth/constants/auth_constant.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AppStateService appStateService = sl<AppStateService>();

  final ProfileController profileController = sl<ProfileController>();

  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameEditFocus = FocusNode();
  final FocusNode _usernameEditFocus = FocusNode();

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    try {
      // await profileController.updateUserProfile();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = appStateService.currentUser;

    /// [Text Edit Controllers]
    ///
    final TextEditingController _nameEditController = TextEditingController(
      text: user?.user.name,
    );

    final TextEditingController _usernameEditController = TextEditingController(
      text: user?.user.username,
    );

    return AppScaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (user != null) ...[
              Align(
                alignment: Alignment.center,
                child: CustomCachedImage.thumbnailRounded(user.user.avatar.url),
              ),
            ],

            Gap.h16,

            /// [Text Field]
            ///
            /// [Name] Text field
            TextFormField(
              controller: _nameEditController,
              focusNode: _nameEditFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: AuthConstants.hint.email,
                // labelText: 'Name',
              ),

              // onFieldSubmitted: (_) {
              //   FocusScope.of(context).requestFocus(_passwordFocus);
              // },
            ),

            Gap.h16,

            /// [Username] Text field
            TextFormField(
              controller: _usernameEditController,
              focusNode: _usernameEditFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: context.primaryInputDecoration.copyWith(
                hintText: AuthConstants.hint.email,
                // labelText: 'User',
              ),

              // onFieldSubmitted: (_) {
              //   FocusScope.of(context).requestFocus(_passwordFocus);
              // },
            ),

            Gap.h16,

            AnimatedBuilder(
              animation: profileController,
              builder: (context, _) {
                return context.primaryButton(
                  onPressed: _submit,
                  text: "Update",
                  // isLoading: _controller.isLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
