import 'package:flutter/material.dart';
import '../../utils/palette.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final TextEditingController controller;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String? initialVal;
  final String? hintText;
  final int minLines;
  final int maxLines;
  final void Function(String?)? onChanged ;

  const CustomTextFormField({
    Key? key,
    this.initialVal,
    this.obscureText,
    this.hintText,
    this.labelText,
    this.minLines = 1,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialVal,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: widget.hintText,
        isDense: true,
        labelText: widget.labelText,
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.bluePostale, width: 1.0),
        ),
      ),
      textInputAction: TextInputAction.done,
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      validator: widget.validator,
      onChanged: widget.onChanged ,
    );
  }
}
