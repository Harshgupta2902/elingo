import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Timer _timer;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_countdown == 0) {
          timer.cancel();
        } else {
          _countdown--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: GlobalColors.secondaryButtonColor,
        borderRadius: SmoothBorderRadius(cornerRadius: 12, cornerSmoothing: 10),
        shape: BoxShape.rectangle,
      ),
      textStyle: Theme.of(context).textTheme.titleLarge,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );

    return Scaffold(
      appBar: const VocabularyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You've got a mail 📥",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Text(
                "We have sent the OTP Verification code to your email address. Check your email and enter the code below.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, color: AppColors.battleshipGrey),
              ),
              const SizedBox(height: 30),
              Center(
                child: Pinput(
                  // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                  keyboardType: TextInputType.number,
                  controller: otpController,
                  length: 4,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  closeKeyboardWhenCompleted: true,
                  pinAnimationType: PinAnimationType.fade,
                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                    border: Border.all(color: GlobalColors.primaryColor),
                  ),
                  defaultPinTheme: defaultPinTheme,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Didn't receive email?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: _countdown > 0
                    ? RichText(
                        text: TextSpan(
                          text: "You can resend code in ",
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: "$_countdown ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: GlobalColors.primaryColor),
                            ),
                            TextSpan(
                              text: "sec",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _countdown = 60;
                          startTimer();
                        },
                        child: Text(
                          "Resend Code",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600, color: GlobalColors.primaryColor),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: GlobalColors.borderColor,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              MyNavigator.popUntilAndPushNamed(GoPaths.createPassword);
            }
          },
          child: const Text("Confirm"),
        ),
      ),
    );
  }
}
