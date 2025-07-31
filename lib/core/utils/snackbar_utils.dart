import 'package:flutter/material.dart';

/// A utility class for showing custom snackbars throughout the app
class SnackbarUtils {
  /// Shows a custom snackbar with the given message
  static void showSnackbar(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Dismiss any existing snackbars first
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: CustomSnackbarContent(
        message: message,
        type: type,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      padding: EdgeInsets.zero,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

/// The type of snackbar to show
enum SnackbarType {
  success,
  error,
  info,
}

/// A custom snackbar content widget
class CustomSnackbarContent extends StatelessWidget {
  final String message;
  final SnackbarType type;

  const CustomSnackbarContent({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getBorderColor(),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: _getTextColor(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case SnackbarType.success:
        iconData = Icons.check_circle_outline;
        iconColor = const Color(0xFF09B850);
        break;
      case SnackbarType.error:
        iconData = Icons.error_outline;
        iconColor = const Color(0xFFCE3837);
        break;
      case SnackbarType.info:
      iconData = Icons.info_outline;
        iconColor = const Color(0xFFF3E898);
        break;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: 20,
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case SnackbarType.success:
        return const Color(0xFF1F2022);
      case SnackbarType.error:
        return const Color(0xFF1F2022);
      case SnackbarType.info:
      return const Color(0xFF1F2022);
    }
  }

  Color _getBorderColor() {
    switch (type) {
      case SnackbarType.success:
        return const Color(0xFF09B850);
      case SnackbarType.error:
        return const Color(0xFFCE3837);
      case SnackbarType.info:
      return const Color(0xFFF3E898);
    }
  }

  Color _getTextColor() {
    switch (type) {
      case SnackbarType.success:
        return const Color(0xFF09B850);
      case SnackbarType.error:
        return const Color(0xFFCE3837);
      case SnackbarType.info:
      return const Color(0xFFF3E898);
    }
  }
}
