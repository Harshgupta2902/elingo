import 'package:flutter/material.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class MySnackBarSuccess {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.success,
            fontWeight: FontWeight.w500,
          )
        ),
        duration: const Duration(milliseconds: 4000),
        backgroundColor: const  Color.fromARGB(255, 131, 236, 124),
      ),
    );
  }
}

class MySnackBarError {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.success,
            fontWeight: FontWeight.w500,
          )
        ),
        duration: const  Duration(milliseconds: 4000),
        backgroundColor:  const Color.fromARGB(255, 236, 124, 124),
      ),
    );
  }
}