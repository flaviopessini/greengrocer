import 'package:flutter/material.dart';
import 'package:greengrocer/src/configs/custom_colors.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback? onPressed;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.isSelected,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      onTap: onPressed,
      child: Center(
        child: Ink(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color:
                  isSelected ? CustomColors.customSwatchColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? Colors.white : CustomColors.customContrastColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
