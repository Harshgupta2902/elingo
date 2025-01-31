import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonLoader extends StatelessWidget {
  const ButtonLoader({
    Key? key,
    required this.isLoading,
    this.loaderString = 'Loading...',
    this.buttonString = 'Invest More',
    this.textStyle,
    this.loaderColor,
  }) : super(key: key);

  final String buttonString;
  final RxBool isLoading;
  final String loaderString;
  final TextStyle? textStyle;
  final Color? loaderColor;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return isLoading.value
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: loaderColor ?? Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    loaderString,
                    style: textStyle ??
                        Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                  )
                ],
              )
            : Text(
                buttonString,
                style: textStyle ??
                    Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
              );
      },
    );
  }
}
