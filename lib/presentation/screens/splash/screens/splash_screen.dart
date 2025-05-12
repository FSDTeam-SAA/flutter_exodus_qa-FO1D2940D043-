import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/pictures/background_pattern.png',
              fit: BoxFit.fitHeight,
            ),
            Align(
              alignment: Alignment.center,
              child: AppLogo(width: 222.0, height: 162.0),
            ),
          ],
        ),
      ),
    );
  }
}
