import 'package:exodus/core/constants/app_gap.dart';
import 'package:exodus/core/constants/app_padding.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/theme/text_style.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/core/utils/extensions/input_decoration_extensions.dart';
import 'package:exodus/core/utils/validator/validators.dart';
import 'package:exodus/presentation/screens/auth/constants/auth_constant.dart';
import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.codeVerify);
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
                          AuthConstants.title.forgotPassword,
                          style: AppText.h1,
                        ),
                        Gap.h8,
                        Text(
                          AuthConstants.subtitle.forgotPassword,
                          style: AppText.bodyRegular,
                        ),
                        Gap.h22,
                        // Name Field
                        TextFormField(
                          controller: _emailController,
                          // textInputAction: TextInputAction.next,
                          decoration: context.primaryInputDecoration.copyWith(
                            hintText: AuthConstants.hint.email,
                            labelText: 'Email',
                          ),
                          validator: Validators.email,
                          onFieldSubmitted: (_) => _submit(),
                        ),

                        Gap.h22,
                        context.primaryButton(
                          onPressed: _submit,
                          text: "Send SMS",
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
