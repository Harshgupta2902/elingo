import 'package:flutter/material.dart';
import 'package:vocablury/home_module/components/bottom_navigation.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key, this.child});

  final Widget? child;

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.child!,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
