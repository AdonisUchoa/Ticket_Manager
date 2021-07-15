import 'package:flutter/material.dart';
import 'package:ticket_manager/shared/themes/app_colors.dart';
import 'package:ticket_manager/shared/themes/app_text_styles.dart';
import 'package:ticket_manager/shared/widgets/set_label_button/set_label_buttons.dart';

class BottomSheetWidget extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnpressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnpressed;
  final String title;
  final String subtitle;

  const BottomSheetWidget({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnpressed,
    required this.secondaryLabel,
    required this.secondaryOnpressed,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RotatedBox(
        quarterTurns: 1,
        child: Material(
          child: Container(
            color: AppColors.shape,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text.rich(
                        TextSpan(
                          text: title,
                          style: TextStyles.buttonBoldHeading,
                          children: [
                            TextSpan(
                              text: "\n$subtitle",
                              style: TextStyles.buttonHeading,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 1,
                      color: AppColors.stroke,
                    ),
                    SetLabelButtons(
                        enablePrimaryColor: true,
                        primaryLabel: primaryLabel,
                        primaryOnpressed: primaryOnpressed,
                        secondaryLabel: secondaryLabel,
                        secondaryOnpressed: secondaryOnpressed)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
