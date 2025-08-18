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
import 'package:exodus/presentation/screens/auth/controllers/login_controller.dart';
import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:exodus/presentation/widgets/form_error_message.dart';
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

  // final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  final _controller = sl<LoginController>();

  @override
  void initState() {
    super.initState();
    // _controller = LoginController(_authRepository);
  }

  @override
  void dispose() {
    // _controller.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> errorMessage() async {
  //   errorMessage = _controller.errorMessage;
  // }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    try {
      await _controller.login(_emailController.text, _passwordController.text);
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
                                  AuthConstants.title.login,
                                  style: AppText.h1,
                                ),
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
                                        () => NavigationService().sailTo(
                                          AppRoutes.forgatePassword,
                                        ),
                                    child: Text(
                                      AuthConstants.label.forgotPassword,
                                      style: TextStyle(
                                        fontSize: AppText.bodyRegular.fontSize,
                                        fontWeight:
                                            AppText.bodyRegular.fontWeight,
                                      ),
                                    ),
                                  ),
                                ),
                                Gap.h22,

                                /// [Submit button]
                                AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, _) {
                                    return context.primaryButton(
                                      onPressed: _submit,
                                      text: "Login",
                                      isLoading: _controller.isLoading,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          // if (!isMobile) ...[

                          /// [Footer] pinned to bottom
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed:
                                      () => NavigationService().sailTo(
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
                            ),
                          ),
                          // ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // if (!isKeyboardVisible && isMobile)
        //   /// [Sign up Button]
        //   Positioned(
        //     left: 0,
        //     right: 0,
        //     bottom: 20,
        //     child: Center(
        //       child: TextButton(
        //         onPressed:
        //             () => NavigationService().sailTo(AppRoutes.signup),
        //             // Navigator.pushNamed(context, ),
        //         child: Text(
        //           AuthConstants.label.noAccount,
        //           style: TextStyle(
        //             color: AppColors.textSecondary,
        //             fontSize: AppSizes.textSizeRegular,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
        // );
        // },
      ),
    );
  }
}
