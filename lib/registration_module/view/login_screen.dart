import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vocablury/components/custom_text_field.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool isChecked = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VocabularyAppBar(
        title: "Login",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                "Hello There 👋",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                labelText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }
                  return validateInput("email", value);
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                labelText: "Password",
                obscureText: isObscure,
                // Set obscureText to the isObscure state.
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                    color: GlobalColors.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Password";
                  }
                  return validateInput("password", value);
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: GlobalColors.primaryColor,
                    onChanged: (value) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                  Text(
                    "Remember me",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: GlobalColors.borderColor, thickness: 2),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => MyNavigator.pushNamed(GoPaths.forgotPassword),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: GlobalColors.primaryColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
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
            context.goNamed(GoPaths.dashboardLevels);

            // if (_formKey.currentState!.validate()) {
            // MyNavigator.popUntilAndPushNamed(GoPaths.profileSuccessScreen);
            // },
          },
          child: const Text("SIGN IN"),
        ),
      ),
    );
  }
}
