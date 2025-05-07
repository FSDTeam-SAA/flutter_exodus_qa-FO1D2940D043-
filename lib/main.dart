import 'package:exodus/core/constants/app_colors.dart';
import 'package:exodus/core/extensions/button_extensions.dart';
import 'package:exodus/core/extensions/input_decoration_extensions.dart';
import 'package:exodus/core/extensions/text_extensions.dart';
import 'package:exodus/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: AppTheme.light,
      home: CheckThemeScreen(),
    );
  }
}

class CheckThemeScreen extends StatelessWidget {
  const CheckThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              style: context.primaryButton,
              onPressed: () {},
              child: Text("Button"),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: context.secondaryButton,
              onPressed: () {},
              child: Text(
                "Button body large",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: context.primaryOutline,
              onPressed: () {},
              child: Text("Button"),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: context.errorOutline,
              onPressed: () {},
              child: Text("Button"),
            ),

            SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: context.primaryButton,
                onPressed: () {},
                child: Text(
                  "Button 2",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),

            SizedBox(height: 20),
            TextFormField(
              onEditingComplete: () => NextFocusAction(),
              decoration: context.standardInputDecoration.copyWith(
                hintText: "test",
              ),
            ),

            SizedBox(height: 20),
            TextFormField(
              onEditingComplete: () => NextFocusAction(),
              decoration: context.standardInputDecoration.copyWith(
                hintText: "test",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
