class AuthConstants {
  const AuthConstants._(); // Prevent instantiation

  static const title = _AuthTitles();
  static const subtitle = _AuthSubtitles();
  static const hint = _AuthHints();
  static const label = _AuthLabels();
}

class _AuthTitles {
  const _AuthTitles();

  final String login = "Login";
  final String signup = "Sign Up";
  final String forgotPassword = "Forgot Password";
  final String securityCode = "Enter security code";
  final String createNewPassword = "Create New Password";
}

class _AuthSubtitles {
  const _AuthSubtitles();

  final String login = "Please sign in to continue.";
  final String forgotPassword =
      "We're sending you SMS notifications to reset your password for security and login purposes.";
  final String verifyCode =
      "Please check your SMS for a message with your code. Your code is 6 numbers long.";
}

class _AuthHints {
  const _AuthHints();

  final String name = "Enter your fullname";
  final String email = "Enter your email";
  final String password = "Enter your password";
  final String confirmPassword = "Confirm your password";
  final String phone = "Enter your Phone number";
  final String resendCode = "Resend code in ";
}

class _AuthLabels {
  const _AuthLabels();

  final String noAccount = "Don't have an account? Sign up";
  final String haveAccount = "Already have an account? Login";
  final String forgotPassword = "Forgot Password?";
  final String signup = "Sign Up";
  final String login = "Login";
  final String sendSms = "Send SMS";
  final String verify = "Verify";
  final String resetPassword = "Reset Password";
}
