import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';

class VocabularyAppBar extends StatefulWidget implements PreferredSizeWidget {
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
  });

  final double? progressValue;
  final bool? showProgress;
  final bool? centerTitle;
  final String? title;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final List<Widget>? actionWidget;
  final Color? appBgColor;

  @override
  State<VocabularyAppBar> createState() => _VocabularyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _VocabularyAppBarState extends State<VocabularyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.appBgColor ?? Colors.transparent,
      elevation: 0,
      leading: widget.leadingWidget ??
          IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                MyNavigator.pop();
              }
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
      centerTitle: widget.centerTitle ?? false,
      actions: widget.actionWidget ?? [],
      title: widget.titleWidget ??
          (widget.showProgress == true
              ? LinearProgressIndicator(
                  color: GlobalColors.primaryColor,
                  value: widget.progressValue,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  minHeight: 8,
                  backgroundColor: GlobalColors.borderColor,
                )
              : widget.title != null
                  ? Text(
                      "${widget.title}",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
                    )
                  : null),
    );
  }
}
