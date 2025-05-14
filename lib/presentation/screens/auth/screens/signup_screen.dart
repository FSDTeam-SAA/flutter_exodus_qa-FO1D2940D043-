import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_padding.dart';
import 'package:exodus/core/constants/app/app_sizes.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/core/utils/extensions/input_decoration_extensions.dart';
import 'package:exodus/core/utils/validator/validators.dart';
import 'package:exodus/presentation/screens/auth/constants/auth_constant.dart';
import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
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
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailFocus.dispose();
    _phoneController.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.home);
    }
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {

    print("Widget build ${count++}");

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0;

    return AppScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate max width for the form (600px for large screens)
          final double maxFormWidth =
              constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
          final bool isMobile = constraints.maxWidth < 600;

          return Stack(
            children: [
              GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Center(
                  child: SingleChildScrollView(
                    padding:
                        isMobile ? AppPaddings.bottom80 : AppPaddings.bottom20,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxFormWidth),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppLogo(height: 117, width: 160),
                            Gap.h32,
                            Text(AuthConstants.title.login, style: AppText.h1),
                            Gap.h8,
                            Text(
                              AuthConstants.subtitle.login,
                              style: AppText.bodyRegular,
                            ),
                            Gap.h22,

                            // Name Field
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

                            // Email Field
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

                            // Phone Field
                            TextFormField(
                              controller: _phoneController,
                              focusNode: _phoneFocus,
                              keyboardType: TextInputType.number,
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

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              obscureText: _obscurePassword,
                              textInputAction: TextInputAction.next,
                              decoration: context.primaryInputDecoration
                                  .copyWith(
                                    hintText: AuthConstants.hint.password,
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: AppColors.inputIcon,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () =>
                                              _obscurePassword =
                                                  !_obscurePassword,
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

                            // Confirm Password Field
                            TextFormField(
                              controller: _confirmPasswordController,
                              focusNode: _confirmPasswordFocus,
                              obscureText: _obscureConfirmPassword,
                              textInputAction: TextInputAction.done,
                              decoration: context.primaryInputDecoration
                                  .copyWith(
                                    hintText: AuthConstants.hint.password,
                                    labelText: "Confirm Password",
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
                                  ),
                              validator:
                                  (value) => Validators.confirmPassword(
                                    value,
                                    _passwordController.text,
                                  ),
                              onFieldSubmitted: (_) => _submit(),
                            ),

                            Gap.h22,
                            context.primaryButton(
                              onPressed: _submit,
                              text: "Sign Up",
                            ),
                            if (isKeyboardVisible || !isMobile) ...[
                              Gap.h16,
                              // Already have an Account
                              TextButton(
                                onPressed:
                                    () => Navigator.pop(context),
                                child: Text(
                                  AuthConstants.label.haveAccount,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: AppSizes.textSizeRegular,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Already have an Account
              if (!isKeyboardVisible && isMobile)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Center(
                    child: TextButton(
                      onPressed:
                          () => Navigator.pop(context),
                      child: Text(
                        AuthConstants.label.haveAccount,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppSizes.textSizeRegular,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
