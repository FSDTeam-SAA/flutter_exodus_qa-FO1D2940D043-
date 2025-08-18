import 'package:exodus/core/constants/app/app_gap.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('About App')),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Text(
            'About Exodus QA',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.left,
          ),
          Gap.h16,
          const Text(
            'Exodus QA offers allows users to share bus rides, typically for commuting, by matching them with others traveling along similar routes. Exodus QA provides features like route planning, real-time bus tracking, and secure payment options. Our goal is to offer a more convenient, affordable, and environmentally friendly transportation option compared to individual travel.',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
