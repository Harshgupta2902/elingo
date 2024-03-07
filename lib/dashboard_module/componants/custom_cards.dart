import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocablury/utilities/constants/assets_path.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';
import 'package:vocablury/utilities/theme/box_decoration.dart';
import 'package:vocablury/utilities/theme/button_decoration.dart';

class ContactCard extends StatelessWidget {
  final String? verb;

  final String? pastSimple;

  final String? pastParticiple;

  final Function() verbTap;
  final Function() pastSimpleTap;
  final Function() pastParticipleTap;

  const ContactCard({
    super.key,
    this.verb,
    this.pastSimple,
    this.pastParticiple,
    required this.verbTap,
    required this.pastSimpleTap,
    required this.pastParticipleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: AppBoxDecoration.getBorderBoxDecoration(
        showShadow: false,
        borderColor: Colors.transparent,
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Base Form: ${verb ?? ""}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Past Simple: ${pastSimple ?? ""}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.cadetGrey,
                    ),
              ),
              Text(
                'Past Participle: ${pastParticiple ?? ""}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.cadetGrey,
                    ),
              ),
            ],
          ),
          // const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 15,
          //     vertical: 5,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             " Phone",
          //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //                   color: AppColors.cadetGrey,
          //                 ),
          //           ),
          //           Text(
          //             " +2348065650633",
          //             style: Theme.of(context).textTheme.bodyLarge,
          //           ),
          //         ],
          //       ),
          //       OutlinedButton(
          //         style: getOutlinedButtonStyle(
          //           borderRadius: 12,
          //           // Provide a value for the borderRadius parameter
          //           foregroundColor: Colors.white,
          //           backgroundColor: Colors.blue,
          //           borderColor: Colors.blue,
          //           borderWidth: 2.0,
          //           buttonColor: Colors.white,
          //           height: 50,
          //           width: 150,
          //         ),
          //         onPressed: () {
          //           if (kDebugMode) {
          //             print("button pressed");
          //           }
          //         },
          //         child: const Text('Book Meeting'),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ContactCardV2 extends StatelessWidget {
  final String name;
  final String post;

  const ContactCardV2({
    super.key,
    required this.name,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: AppBoxDecoration.getBorderBoxDecoration(
        showShadow: false,
        color: AppColors.scienceBlue,
        borderRadius: 16,
        borderColor: Colors.transparent,
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    height: 44,
                    width: 44,
                    "assets/svg_images/icon.svg",
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.white,
                            ),
                      ),
                      Text(
                        post,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.white.withOpacity(
                                0.5,
                              ),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                height: 44,
                width: 44,
                "assets/svg_images/call.svg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReadingWordsContainer extends StatelessWidget {
  final String? baseForm;
  final String? pastSimple;
  final String? pastParticiple;
  final Function() verbTap;
  final Function() pastSimpleTap;
  final Function() pastParticipleTap;
  final int? index;

  const ReadingWordsContainer({
    Key? key,
    this.baseForm,
    this.pastSimple,
    this.pastParticiple,
    required this.verbTap,
    required this.pastSimpleTap,
    required this.pastParticipleTap,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBoxDecoration.customBoxDecoration(
        showShadow: false,
        color: AppColors.zircon
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (index == 0) // Show headings only for the first row
            _buildHeadings(context),
          const SizedBox(height: 10),
          _buildRow(context, baseForm, pastSimple, pastParticiple),
        ],
      ),
    );
  }

  Widget _buildHeadings(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeadingCell(context, 'Base Form'),
        _buildHeadingCell(context, 'Past Simple'),
        _buildHeadingCell(context, 'Past Participle'),
      ],
    );
  }

  Widget _buildHeadingCell(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.black,
          ),
    );
  }

  Widget _buildRow(BuildContext context, String? baseForm, String? pastSimple, String? pastParticiple) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDataCell(context, baseForm, verbTap),
        _buildDataCell(context, pastSimple, pastSimpleTap),
        _buildDataCell(context, pastParticiple, pastParticipleTap),
      ],
    );
  }

  Widget _buildDataCell(BuildContext context, String? data, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 10),
            SvgPicture.asset(
              AssetPath.speaker,
              height: 20,
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class AssignMeAnExpert extends StatelessWidget {
  const AssignMeAnExpert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 14,
      ),
      decoration: AppBoxDecoration.getBorderBoxDecoration(
        showShadow: false,
        borderColor: Colors.transparent,
        color: AppColors.ultramarineBlue,
        borderRadius: 14,
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 12),
                Text(
                  "Time is running out! Find your dream University now",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Buy our 99 plan to begin your personalised study abroad journey",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ],
            ),
          ),
          Image.asset(
            height: 88,
            width: 75,
            "assets/svg_images/time.png",
          ),
        ],
      ),
    );
  }
}

class UniversityApplicationsCard extends StatelessWidget {
  const UniversityApplicationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: AppBoxDecoration.getBorderBoxDecoration(
        showShadow: false,
        borderColor: Colors.transparent,
        color: AppColors.white,
        borderRadius: 14,
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text(
                  "M.S. in Engineering Management",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.black,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...List.generate(5, (index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Text(
                    "University:",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.black,
                        ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Johns Hopkins University",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.black,
                      ),
                ),
              ],
            );
          }),
          OutlinedButton(
            style: getOutlinedButtonStyle(
              borderRadius: 14,
              // Provide a value for the borderRadius parameter

              buttonColor: AppColors.scienceBlue,
              borderColor: Colors.transparent,
              backgroundColor: Colors.white,
              borderWidth: 0.0,
              height: 50,
              width: 150,
            ),
            onPressed: () {
              if (kDebugMode) {
                print("Assign Me an Expert");
              }
            },
            child: const Text('Assign Me an Expert'),
          ),
        ],
      ),
    );
  }
}

class AddApplication extends StatelessWidget {
  const AddApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AssetPath.background, // Replace with your image asset path
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Text(
                  "Good Morning Divyansh",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "10",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            "Shortlisted",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.cadetGrey,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "4",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            "Applied",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.cadetGrey,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -------------------------------  DropdownContainer --------------------------------------

class DropdownContainer extends StatefulWidget {
  const DropdownContainer({super.key});

  @override
  DropdownContainerState createState() => DropdownContainerState();
}

class DropdownContainerState extends State<DropdownContainer> {
  String dropdownValue = '2024';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: AppBoxDecoration.getBorderBoxDecoration(
        showShadow: false,
        color: AppColors.alabaster,
        borderRadius: 5,
        borderColor: AppColors.cadetGrey,
      ),
      child: DropdownButtonHideUnderline(
        // Hide the dropdown underline
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['2024', '2025', '2026'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.cadetGrey,
                    ),
              ),
            );
          }).toList(),
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.cadetGrey,
          ), // Set the icon property to null to hide the dropdown icon
        ),
      ),
    );
  }
}
