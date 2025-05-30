import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/core/utils/extensions/code_input_decoration_extensions.dart';
import 'package:exodus/domain/usecases/auth/verify_otp_usecase.dart';
import 'package:exodus/presentation/screens/auth/controllers/verify_code_controller.dart';
import 'package:exodus/presentation/widgets/form_error_message.dart';
import 'package:flutter/material.dart';
import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/core/constants/app/app_padding.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/presentation/screens/auth/constants/auth_constant.dart';
import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';

class SecurityCodeScreen extends StatefulWidget {
  final String? email;
  final bool fromLogin;
  const SecurityCodeScreen({super.key, this.email, this.fromLogin = false});

  @override
  State<SecurityCodeScreen> createState() => _SecurityCodeScreenState();
}

class _SecurityCodeScreenState extends State<SecurityCodeScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _digitControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool _isLoading = false;

  final _verifyCodeController = sl<VerifyCodeController>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Combine all digits into a single code
      final code = _digitControllers.map((c) => c.text).join();

      await Future.delayed(const Duration(seconds: 1)); // Simulate network call

      if (mounted) {
        dPrint("Code Print $code");
        dPrint("Email in Code Print ${widget.email}");

        final result = await _verifyCodeController.verifyCode(
          widget.email!,
          code,
        );

        if (result) {
          if (widget.fromLogin) {
            NavigationService().freshStartTo(AppRoutes.login);
          } else if (!widget.fromLogin) {
            NavigationService().freshStartTo(
              AppRoutes.createNewPassword,
              arguments: {'email': widget.email},
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Verification failed: ${e.toString()}')),
        // );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _onDigitChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    // Auto-submit when last digit is entered
    if (value.length == 1 && index == 5) {
      _submit();
    }
  }

  @override
  void dispose() {
    for (var controller in _digitControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                        const AppLogo(height: 117, width: 160),
                        Gap.h32,

                        /// [Api Error messages]
                        AnimatedBuilder(
                          animation: _verifyCodeController,
                          builder: (context, _) {
                            return FormErrorMessage(
                              message: _verifyCodeController.errorMessage,
                            );
                          },
                        ),
                        Text(
                          AuthConstants.title.securityCode,
                          style: AppText.h1,
                        ),
                        Gap.h8,
                        Text(
                          AuthConstants.subtitle.verifyCode,
                          style: AppText.bodyRegular,
                        ),
                        Gap.h16,

                        // 6-digit code input
                        _buildCodeInputField(),
                        Gap.h16,
                        _buildResendCodeOption(),

                        Gap.h22,
                        // Verify button
                        context.primaryButton(
                          onPressed: () => _submit(),
                          text: _isLoading ? "Verifying..." : "Verify",
                        ),

                        // Resend code option
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

  Widget _buildCodeInputField() {
    return context.buildCodeInputField(
      controllers: _digitControllers,
      focusNodes: _focusNodes,
      onDigitChanged: _onDigitChanged,
    );
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: List.generate(6, (index) {
    //     return Container(
    //       width: 48,
    //       height: 56,
    //       margin: const EdgeInsets.symmetric(horizontal: 16),
    //       child: TextFormField(
    //         controller: _digitControllers[index],
    //         focusNode: _focusNodes[index],
    //         keyboardType: TextInputType.number,
    //         textAlign: TextAlign.center,
    //         maxLength: 1,
    //         style: AppText.bodyMedium,
    //         decoration: InputDecoration(
    //           counterText: '',
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(8),
    //           ),
    //           enabledBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(8),
    //             borderSide: BorderSide(
    //               color: Theme.of(context).colorScheme.outline,
    //             ),
    //           ),
    //           focusedBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(8),
    //             borderSide: BorderSide(
    //               color: Theme.of(context).colorScheme.primary,
    //               width: 2,
    //             ),
    //           ),
    //           filled: true,
    //           fillColor: Theme.of(context).colorScheme.surface,
    //         ),
    //         validator: (value) {
    //           if (value == null || value.isEmpty) {
    //             return '';
    //           }
    //           return null;
    //         },
    //         onChanged: (value) => _onDigitChanged(value, index),
    //       ),
    //     );
    //   }),
    // );
  }

  Widget _buildResendCodeOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            _isLoading
                ? null
                : () {
                  /// `TODO`: Implement resend logic
                };
          },
          child: Text(AuthConstants.hint.resendCode),
        ),
        // TextButton(
        //   onPressed:
        // _isLoading
        //     ? null
        //     : () {
        //       /// `TODO`: Implement resend logic
        //     },
        //   child: Text(AuthConstants.hint.resendCode),
        // ),
      ],
    );
  }
}
