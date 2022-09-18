import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? leftIcon;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final GlobalKey<FormFieldState>? formKey;
  final bool readOnly;
  final bool isSecret;

  const CustomTextField({
    Key? key,
    this.controller,
    this.leftIcon,
    this.label,
    this.inputFormatters,
    this.inputType,
    this.initialValue,
    this.validator,
    this.onSaved,
    this.formKey,
    this.readOnly = false,
    this.isSecret = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formKey,
      controller: widget.controller,
      initialValue: widget.initialValue,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.inputType,
      onSaved: widget.onSaved,
      validator: widget.validator,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        prefixIcon: widget.leftIcon != null ? Icon(widget.leftIcon) : null,
        suffixIcon: widget.isSecret
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: isObscure
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : null,
        labelText: widget.label,
      ),
      obscureText: isObscure,
    );
  }
}
