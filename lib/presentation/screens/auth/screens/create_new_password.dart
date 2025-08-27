import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_padding.dart';
import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/core/utils/extensions/input_decoration_extensions.dart';
import 'package:exodus/core/utils/validator/validators.dart';
import 'package:exodus/presentation/screens/auth/constants/auth_constant.dart';
import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../controllers/login_controller.dart';
import '../controllers/password_reset_controller.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String otp;
  const CreateNewPasswordScreen({super.key, required this.otp});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _repeatNewPasswordFocus = FocusNode();

  bool _obscureNewPassword = true;
  bool _obscureNewConfirmPassword = true;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatNewPasswordController =
      TextEditingController();

  final _controller = sl<PasswordResetController>();
  final _secureStorage = sl<SecureStoreServices>();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final email = await _secureStorage.retrieveData(KeyConstants.email);

      final result = await _controller.resetPassword(
        email!,
        widget.otp,
        _repeatNewPasswordController.text,
      );

      if (result && mounted) {
        SnackbarUtils.showSnackbar(context, message: _controller.errorMessage);
        NavigationService().freshStartTo(AppRoutes.login);
      }

      // Navigator.pushNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate max width for the form (600px for large screens)
          final double maxFormWidth =
              constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
          final bool isMobile = constraints.maxWidth < 600;

          return Center(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: isMobile ? AppPaddings.bottom80 : AppPaddings.bottom20,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxFormWidth),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppLogo(height: 117, width: 160),
                        Gap.h32,
                        Text(
                          AuthConstants.title.createNewPassword,
                          style: AppText.h1,
                        ),

                        Gap.h22,

                        // Password Field
                        TextFormField(
                          controller: _newPasswordController,
                          focusNode: _newPasswordFocus,
                          obscureText: _obscureNewPassword,
                          textInputAction: TextInputAction.next,
                          decoration: context.primaryInputDecoration.copyWith(
                            hintText: AuthConstants.hint.password,
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureNewPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.inputIcon,
                              ),
                              onPressed: () {
                                setState(
                                  () =>
                                      _obscureNewPassword =
                                          !_obscureNewPassword,
                                );
                              },
                            ),
                          ),
                          validator: Validators.password,
                          onFieldSubmitted: (_) {
                            FocusScope.of(
                              context,
                            ).requestFocus(_repeatNewPasswordFocus);
                          },
                        ),

                        Gap.h16,

                        // Confirm Password Field
                        TextFormField(
                          controller: _repeatNewPasswordController,
                          focusNode: _repeatNewPasswordFocus,
                          obscureText: _obscureNewConfirmPassword,
                          textInputAction: TextInputAction.done,
                          decoration: context.primaryInputDecoration.copyWith(
                            hintText: AuthConstants.hint.password,
                            labelText: "Confirm Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureNewConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.inputIcon,
                              ),
                              onPressed: () {
                                setState(
                                  () =>
                                      _obscureNewConfirmPassword =
                                          !_obscureNewConfirmPassword,
                                );
                              },
                            ),
                          ),
                          validator:
                              (value) => Validators.confirmPassword(
                                value,
                                _newPasswordController.text,
                              ),
                          onFieldSubmitted: (_) => _submit(),
                        ),

                        Gap.h22,
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return context.primaryButton(
                              onPressed: _submit,
                              text: "Continue",
                              isLoading: _controller.isLoading,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
