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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            /// [Logo]
                            AppLogo(height: 117, width: 160),

                            Gap.h32,

                            /// [Title]
                            Text(AuthConstants.title.login, style: AppText.h1),
                            Gap.h8,

                            /// [Subtitle]
                            Text(
                              AuthConstants.subtitle.login,
                              style: AppText.bodyRegular,
                            ),
                            Gap.h22,

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
                                ).requestFocus(_passwordFocus);
                              },
                            ),

                            Gap.h16,

                            /// [Password Text field]
                            TextFormField(
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              obscureText: _obscurePassword,
                              textInputAction: TextInputAction.done,
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
                              onFieldSubmitted: (_) => _submit(),
                            ),
                            Gap.h16,

                            /// [Forgote Password button]
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap:
                                    () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.forgatePassword,
                                    ),
                                child: Text(
                                  AuthConstants.label.forgotPassword,
                                  style: TextStyle(
                                    fontSize: AppText.bodyRegular.fontSize,
                                    fontWeight: AppText.bodyRegular.fontWeight,
                                  ),
                                ),
                              ),
                            ),
                            Gap.h22,

                            /// [Submit button]
                            context.primaryButton(
                              onPressed: _submit,
                              text: "Login",
                            ),
                            if (!isMobile) ...[
                              Gap.h16,

                              /// [Sign up button]
                              TextButton(
                                onPressed:
                                    () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.signup,
                                    ),
                                child: Text(
                                  AuthConstants.label.noAccount,
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
              if (isMobile)
                /// [Sign up Button]
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Center(
                    child: TextButton(
                      onPressed:
                          () => Navigator.pushNamed(context, AppRoutes.signup),
                      child: Text(
                        AuthConstants.label.noAccount,
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
