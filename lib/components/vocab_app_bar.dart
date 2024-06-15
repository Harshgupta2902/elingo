import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';

class VocabularyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VocabularyAppBar({
    super.key,
    this.progressValue = 0,
    this.showProgress = false,
    this.title,
    this.centerTitle,
    this.titleWidget,
    this.leadingWidget,
    this.actionWidget,
    this.appBgColor,
    this.leadingColor,
  });

  final double? progressValue;
  final bool? showProgress;
  final bool? centerTitle;
  final String? title;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final List<Widget>? actionWidget;
  final Color? appBgColor;
  final Color? leadingColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBgColor ?? Colors.transparent,
      elevation: 0,
      leading: leadingWidget ??
          IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                MyNavigator.pop();
              }
            },
            icon: Icon(Icons.arrow_back, color: leadingColor ?? Colors.black),
          ),
      centerTitle: centerTitle ?? false,
      actions: actionWidget ?? [],
      title: titleWidget ??
          (showProgress == true
              ? LinearProgressIndicator(
                  color: GlobalColors.primaryColor,
                  value: progressValue,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  minHeight: 8,
                  backgroundColor: GlobalColors.borderColor,
                )
              : title != null
                  ? Text(
                      "$title",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: leadingColor ?? Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    )
                  : null),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
