import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/validators.dart';

class CreateProfileForm extends StatefulWidget {
  const CreateProfileForm({super.key});

  @override
  State<CreateProfileForm> createState() => _CreateProfileFormState();
}

class _CreateProfileFormState extends State<CreateProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController controller = PageController();
  int currentPageIndex = 0;

  double progressValue = 0.0;
  final Map<String, String> _formData = {};
  final Map<String, bool> _obscureTextMap = {};

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is your name? 👦👧",
      "label": "Full Name",
      "obscure": false,
      "type": "text",
    },
    {
      "question": "How old are you? 🎂",
      "label": "Age",
      "obscure": false,
      "type": "number",
    },
    {
      "question": "What is your email address? ✉",
      "label": "Email",
      "obscure": false,
      "type": "email",
    },
    {
      "question": "Create a password? 🔐",
      "label": "Password",
      "obscure": true,
      "type": "password",
    },
  ];

  @override
  Widget build(BuildContext context) {
    progressValue = (currentPageIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => MyNavigator.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: LinearProgressIndicator(
          color: GlobalColors.primaryColor,
          value: progressValue,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          minHeight: 8,
          backgroundColor: GlobalColors.borderColor,
        ),
      ),
      body: Form(
        key: _formKey,
        child: PageView.builder(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) async {
            setState(() {
              currentPageIndex = value;
            });
          },
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final isObscure = questions[index]['obscure'] as bool;
            if (isObscure && !_obscureTextMap.containsKey(questions[index]['label'])) {
              _obscureTextMap[questions[index]['label']!] = true;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questions[index]['question']!,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: _formData[questions[index]['label']] ?? '',
                    cursorColor: GlobalColors.primaryColor,
                    obscureText: isObscure ? _obscureTextMap[questions[index]['label']]! : false,
                    keyboardType: getKeyboardType(questions[index]['type']!),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    decoration: InputDecoration(
                      label: Text(
                        questions[index]['label']!,
                      ),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalColors.primaryColor,
                        ),
                      ),
                      suffixIcon: isObscure
                          ? IconButton(
                              icon: Icon(
                                _obscureTextMap[questions[index]['label']]!
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: GlobalColors.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureTextMap[questions[index]['label']!] =
                                      !_obscureTextMap[questions[index]['label']]!;
                                });
                              },
                            )
                          : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter ${questions[index]['label'].toString()}";
                      }
                      return validateInput(questions[index]['type']!, value);
                    },
                    onChanged: (value) {
                      setState(() {
                        _formData[questions[index]['label']!] = value;
                      });
                    },
                  )
                ],
              ),
            );
          },
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
              if (currentPageIndex + 1 < questions.length) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.linear,
                );
              } else {
                debugPrint(_formData.toString());
                MyNavigator.popUntilAndPushNamed(GoPaths.profileSuccessScreen);
              }
            }
          },
          child: const Text("CONTINUE"),
        ),
      ),
    );
  }
}
