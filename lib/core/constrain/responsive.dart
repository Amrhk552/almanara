import 'package:flutter/material.dart';

// Constants for breakpoints and durations
const double kTabletBreakpoint = 600;
const double kWebBreakpoint = 802;
const Duration kAnimationDuration = Duration(milliseconds: 500);

class ResponsiveWidget extends StatelessWidget {
  final Widget web;
  final Widget? tablet; // Optional tablet parameter
  final Widget mobile;

  const ResponsiveWidget({
    super.key,
    required this.web,
    this.tablet, // Optional
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kAnimationDuration,
      reverseDuration: kAnimationDuration,
      child:
          //  web,
          ScreenHelper.getScreenType(context) == ScreenType.mobile
              ? mobile
              : ScreenHelper.getScreenType(context) == ScreenType.web || tablet == null
                  ? web
                  : tablet,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
    );
  }
}

enum ScreenType { mobile, tablet, web }

class ScreenHelper {
  static double screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double screenHeight(BuildContext context) => MediaQuery.sizeOf(context).height;

  static bool isWeb(BuildContext context) => getScreenType(context) == ScreenType.web;
  static bool isMobile(BuildContext context) => getScreenType(context) == ScreenType.mobile;

  static ScreenType getScreenType(BuildContext context) {
    final width = screenWidth(context);
    if (width >= kWebBreakpoint) {
      return ScreenType.web;
    } else if (width >= kTabletBreakpoint && width < kWebBreakpoint) {
      return ScreenType.tablet;
    } else {
      return ScreenType.mobile;
    }
  }

  static double getDialogWidth(BuildContext context) {
    switch (getScreenType(context)) {
      case ScreenType.mobile:
        return screenWidth(context) * .95;
      case ScreenType.tablet:
        return screenWidth(context) * .95;
      case ScreenType.web:
        return screenWidth(context) * .6;
    }
  }

  static int dynamicCrossAxisCount(BuildContext context) =>
      screenWidth(context) / 350 < 2 ? 1 : (screenWidth(context) / 400).toInt();
}
