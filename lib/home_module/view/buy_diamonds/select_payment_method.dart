import 'package:flutter/material.dart';
import 'package:vocablury/components/vocab_app_bar.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/navigator.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  int _selectedRadioIndex = -1;
  Map<String, String> selectedPaymentMethod = {};

  static const paymentMethods = [
    {
      'image': 'https://cdn.pixabay.com/photo/2018/05/08/21/29/paypal-3384015_1280.png',
      'name': 'PayPal',
      'radioId': 'paypal',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRon0edsTcidGmV0UoWcBzLUtJB7nTrVMsf0Wi8thVMJ-dQONH_c30m6Mbj5PKJUkpLBoI&usqp=CAU',
      'name': 'Google Pay',
      'radioId': 'gpay',
    },
    {
      'image':
          'https://static.vecteezy.com/system/resources/previews/019/766/198/large_2x/apple-logo-apple-icon-transparent-free-png.png',
      'name': 'Apple Pay',
      'radioId': 'apay',
    },
    {
      'image': 'https://i.pinimg.com/736x/56/fd/48/56fd486a48ff235156b8773c238f8da9.jpg',
      'name': '.... .... .... 5252',
      'radioId': 'card1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VocabularyAppBar(
        title: "Select Payment Method",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 20),
          itemCount: paymentMethods.length,
          itemBuilder: (context, index) {
            final paymentMethod = paymentMethods[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRadioIndex = index;
                  selectedPaymentMethod = {
                    'name': paymentMethod['name']!,
                    'image': paymentMethod['image']!,
                  };
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(cornerRadius: 16),
                    side: const BorderSide(color: GlobalColors.borderColor, width: 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 52,
                          height: 52,
                          child: Image.network(
                            paymentMethod['image']!,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          paymentMethod['name']!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Radio(
                      value: index,
                      groupValue: _selectedRadioIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedRadioIndex = value as int;
                          selectedPaymentMethod = {
                            'name': paymentMethods[_selectedRadioIndex]['name']!,
                            'image': paymentMethods[_selectedRadioIndex]['image']!,
                          };
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
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
            if (_selectedRadioIndex != -1) {
              MyNavigator.pushNamed(
                GoPaths.reviewSummary,
                extra: {
                  'selectedPaymentMethod': selectedPaymentMethod,
                },
              );
            }
          },
          child: const Text("Continue"),
        ),
      ),
    );
  }
}
