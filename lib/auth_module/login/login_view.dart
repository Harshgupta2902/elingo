import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vocablury/components/custom_text_field.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/constants/button_loader.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';
import 'package:vocablury/utilities/validators/generic_validator.dart';
import 'package:vocablury/utilities/validators/my_regex.dart';

final _formKey = GlobalKey<FormState>();
// final _loginController = Get.put(LoginController());

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [

            // TODO :  add app logo here
            // SvgPicture.asset(
            //   AssetPath.testSvg,
            //   height: MediaQuery.of(context).size.height * 0.1,
            // ),
            SizedBox(height: 10, width: MediaQuery.of(context).size.width),
            Text(
              "Your hassle-free journey starts here!",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w300),
            ),
            Container(
              decoration: AppBoxDecoration.getBoxDecoration(
                borderRadius: 14,
                showShadow: false,
              ),
              margin: const EdgeInsets.all(26),
              // constraints: getConstraints(context),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      hintText: "Email",
                      controller: emailController,
                      validator: (value) {
                        return GenericValidator.required(
                              value: value,
                              message: "Please enter email",
                            ) ??
                            GenericValidator.regexMatch(
                              value: value,
                              regex: MyRegex.emailPattern,
                              message: "Invalid email",
                            );
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: "Password",
                      controller: passwordController,
                      obscureText: showPass,
                      validator: (value) {
                        return GenericValidator.required(
                          value: value,
                          message: "Please enter password",
                        );
                      },
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          child: SvgPicture.asset(
                            showPass ? AssetPath.hide : AssetPath.show,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: AppBoxDecoration.getBoxDecoration(
                        color: Colors.red,
                        shadowColor: AppColors.scienceBlue.withOpacity(0.25),
                        offsetX: 4,
                        offsetY: 8,
                        blurRadius: 24,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width, 60),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() == true) {
                            debugPrint("check the values for login ");
                            // await _loginController.login(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            // );
                            // MyNavigator.pushReplacementNamed(GoPaths.home);
                          }
                          debugPrint("outside");
                        },
                        child: ButtonLoader(
                          isLoading: false.obs,
                          loaderString: "Signing In...",
                          buttonString: "Sign In",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
