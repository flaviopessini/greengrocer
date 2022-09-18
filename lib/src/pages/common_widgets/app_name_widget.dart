import 'package:flutter/material.dart';
import 'package:greengrocer/src/configs/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  final double textSize;
  final Color? greenTitleColor;

  const AppNameWidget({
    Key? key,
    this.greenTitleColor,
    this.textSize = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
        ),
        children: [
          TextSpan(
            text: 'Green',
            style: TextStyle(
              color: greenTitleColor ?? CustomColors.customSwatchColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'grocer',
            style: TextStyle(
              color: CustomColors.customContrastColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
