import 'dart:io';

import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/services/app_state_service.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/core/utils/extensions/input_decoration_extensions.dart';
import 'package:exodus/core/utils/snackbar_utils.dart';
import 'package:exodus/presentation/screens/profile/controllers/profile_controller.dart';
import 'package:exodus/presentation/screens/profile/model/user_profile_update_model.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/image_picker_service.dart';
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

  late final TextEditingController nameEditController;
  late final TextEditingController usernameEditController;

  XFile? _pickedImage;

  final pickerService = ImagePickerService();

  @override
  void initState() {
    super.initState();
    final user = appStateService.currentUser;
    nameEditController = TextEditingController(text: user?.user.name);
    usernameEditController = TextEditingController(
      text: user != null ? '@${user.user.username}' : null,
    );
  }

  @override
  void dispose() {
    nameEditController.dispose();
    usernameEditController.dispose();
    _nameEditFocus.dispose();
    _usernameEditFocus.dispose();
    super.dispose();
  }

  void pickSingleImage() async {
    final image = await pickerService.pickImage();
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (_pickedImage == null) {
      SnackbarUtils.showSnackbar(
        context,
        message: "Add picture",
        type: SnackbarType.info,
      );
    }
    // if (!_formKey.currentState!.validate()) return;

    dPrint(appStateService.currentUser!.user.id);
    dPrint(_pickedImage!.name.toString());

    if (_pickedImage != null) {
      try {
        await profileController.updateUserProfile(
          UserProfileUpdateModel(
            id: appStateService.currentUser?.user.id ?? "",
            // name: nameEditController.text,
          ),
          avatarFile: _pickedImage,
        );
      } catch (e) {
        dPrint(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = appStateService.currentUser;

    // /// [Text Edit Controllers]
    // ///
    // final TextEditingController nameEditController = TextEditingController(
    //   text: user?.user.name,
    // );

    // final TextEditingController usernameEditController = TextEditingController(
    //   text: user != null ? '@${user.user.username}' : null,
    // );

    return AppScaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (user != null) ...[
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    pickSingleImage();
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _pickedImage != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              File(_pickedImage!.path),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                          : CustomCachedImage.thumbnailRounded(
                            user.user.avatar.url,
                          ),

                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: Container(
                          width: 31,
                          height: 31,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                            border: Border.all(color: AppColors.background),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            Gap.h24,

            /// [Text Field]
            ///
            /// [Name] Text field
            TextFormField(
              controller: nameEditController,
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
              controller: usernameEditController,
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
