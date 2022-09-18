import 'package:flutter/material.dart';
import 'package:greengrocer/src/configs/custom_colors.dart';

class QuantityWidget extends StatelessWidget {
  final int value;
  final String suffixText;
  final bool isRemovable;
  final Function(int quantity) result;

  const QuantityWidget({
    Key? key,
    required this.value,
    required this.suffixText,
    required this.result,
    this.isRemovable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1.0,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            icon: !isRemovable || value > 1
                ? Icons.remove
                : Icons.delete_forever_outlined,
            color: !isRemovable || value > 1
                ? null
                : CustomColors.customContrastColor,
            onTap: () {
              if (value == 1 && !isRemovable) {
                return;
              }
              result(value - 1);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              '$value$suffixText',
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _StepButton(
            icon: Icons.add,
            color: CustomColors.customSwatchColor,
            onTap: () {
              result(value + 1);
            },
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final void Function()? onTap;

  const _StepButton({
    Key? key,
    required this.icon,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50.0),
        child: Ink(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color ?? Colors.grey.shade500,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16.0,
          ),
        ),
      ),
    );
  }
}
