import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_padding.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/core/utils/extensions/input_decoration_extensions.dart';
import 'package:exodus/core/utils/validator/validators.dart';
import 'package:exodus/presentation/screens/auth/constants/auth_constant.dart';
import 'package:exodus/presentation/screens/auth/controllers/register_controller.dart';
import 'package:exodus/presentation/screens/auth/model/register_request.dart';
import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:exodus/presentation/widgets/form_error_message.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _controller = sl<RegisterController>();

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    try {
      await _controller.register(
        RegisterRequest(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Form(
                    key: _formKey,
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /// [Logo]
                                AppLogo(height: 117, width: 160),
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

                                /// [Title]
                                Text(
                                  AuthConstants.title.signup,
                                  style: AppText.h1,
                                ),
                                Gap.h8,

                                // /// [Subtitle]
                                // Text(
                                //   AuthConstants.subtitle.,
                                //   style: AppText.bodyRegular,
                                // ),
                                // Gap.h22,

                                /// [Name Text field]
                                TextFormField(
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  textInputAction: TextInputAction.next,
                                  decoration: context.primaryInputDecoration
                                      .copyWith(
                                        hintText: AuthConstants.hint.name,
                                        labelText: 'Name',
                                      ),
                                  validator: Validators.name,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(_emailFocus);
                                  },
                                ),
                                Gap.h16,

                                /// [Email Text field]
                                TextFormField(
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: context.primaryInputDecoration
                                      .copyWith(
                                        hintText: AuthConstants.hint.email,
                                        labelText: 'Email',
                                      ),
                                  validator: Validators.email,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(_phoneFocus);
                                  },
                                ),
                                Gap.h16,

                                /// [Phone Text field]
                                TextFormField(
                                  controller: _phoneController,
                                  focusNode: _phoneFocus,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  decoration: context.primaryInputDecoration
                                      .copyWith(
                                        hintText: AuthConstants.hint.phone,
                                        labelText: 'Phone',
                                      ),
                                  validator: Validators.phone,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(_passwordFocus);
                                  },
                                ),
                                Gap.h16,

                                /// [Password Text field]
                                TextFormField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocus,
                                  obscureText: _obscurePassword,
                                  textInputAction: TextInputAction.next,
                                  decoration: context.primaryInputDecoration
                                      .copyWith(
                                        hintText: AuthConstants.hint.password,
                                        labelText: 'Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: AppColors.inputIcon,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
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

                                /// [Confirm Password Text field]
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  focusNode: _confirmPasswordFocus,
                                  obscureText: _obscureConfirmPassword,
                                  textInputAction: TextInputAction.done,
                                  decoration: context.primaryInputDecoration
                                      .copyWith(
                                        hintText: AuthConstants.hint.password,
                                        labelText: 'Confirm Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureConfirmPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: AppColors.inputIcon,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureConfirmPassword =
                                                  !_obscureConfirmPassword;
                                            });
                                          },
                                        ),
                                      ),
                                  validator:
                                      (value) => Validators.confirmPassword(
                                        value,
                                        _passwordController.text,
                                      ),
                                  onFieldSubmitted: (_) => _submit(),
                                ),
                                Gap.h22,

                                /// [Submit button]
                                AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, _) {
                                    return context.primaryButton(
                                      onPressed: _submit,
                                      text: 'Sign Up',
                                      isLoading: _controller.isLoading,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          /// [Footer]
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed:
                                      () => NavigationService().sailTo(
                                        AppRoutes.login,
                                      ),
                                  child: Text(
                                    AuthConstants.label.haveAccount,
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: AppSizes.textSizeRegular,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
