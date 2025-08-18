import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_padding.dart';
import 'package:exodus/core/constants/app/key_constants.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/core/utils/extensions/input_decoration_extensions.dart';
import 'package:exodus/core/utils/validator/validators.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/service_locator.dart';
import '../../../widgets/form_error_message.dart';
import '../../auth/controllers/password_reset_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _currentPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _controller = sl<PasswordResetController>();
  final _secureStorage = sl<SecureStoreServices>();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final email = await _secureStorage.retrieveData(KeyConstants.email);

      _controller.changePassword(
        email!,
        _currentPasswordController.text,
        _confirmPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: false,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double maxFormWidth =
              constraints.maxWidth > 600 ? 600 : constraints.maxWidth;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              // padding: isMobile ? AppPaddings.all16 : AppPaddings.all20,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxFormWidth),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Gap.h32,
                      TextFormField(
                        controller: _currentPasswordController,
                        focusNode: _currentPasswordFocus,
                        obscureText: _obscureCurrentPassword,
                        textInputAction: TextInputAction.next,
                        decoration: context.primaryInputDecoration.copyWith(
                          hintText: 'Enter current password',
                          labelText: 'Current Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureCurrentPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.inputIcon,
                            ),
                            onPressed: () {
                              setState(
                                () =>
                                    _obscureCurrentPassword =
                                        !_obscureCurrentPassword,
                              );
                            },
                          ),
                        ),
                        validator: Validators.password,
                        onFieldSubmitted: (_) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_newPasswordFocus);
                        },
                      ),
                      Gap.h16,
                      TextFormField(
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocus,
                        obscureText: _obscureNewPassword,
                        textInputAction: TextInputAction.next,
                        decoration: context.primaryInputDecoration.copyWith(
                          hintText: 'Enter new password',
                          labelText: 'New Password',
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
                                    _obscureNewPassword = !_obscureNewPassword,
                              );
                            },
                          ),
                        ),
                        validator: Validators.password,
                        onFieldSubmitted: (_) {
                          FocusScope.of(
                            context,
                          ).requestFocus(_confirmPasswordFocus);
                        },
                      ),
                      Gap.h16,
                      TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        obscureText: _obscureConfirmPassword,
                        textInputAction: TextInputAction.done,
                        decoration: context.primaryInputDecoration.copyWith(
                          hintText: 'Confirm new password',
                          labelText: 'Confirm New Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.inputIcon,
                            ),
                            onPressed: () {
                              setState(
                                () =>
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword,
                              );
                            },
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.inputBorder,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:
                            (value) => Validators.confirmPassword(
                              value,
                              _newPasswordController.text,
                            ),
                        onFieldSubmitted: (_) => _submit(),
                      ),
                      Gap.h32,

                      /// [Api Error messages]
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return FormErrorMessage(
                            message: _controller.errorMessage,
                          );
                        },
                      ),
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          return context.primaryButton(
                            onPressed: _submit,
                            text: "Change Password",
                            isLoading: _controller.isLoading,
                          );
                        },
                      ),
                      // context.primaryButton(onPressed: _submit, text: 'Save'),
                    ],
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
