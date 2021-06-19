import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MyTextField extends StatelessWidget {
  MyTextField(
      {Key? key,
      this.hintText = '',
      required this.controller,
      this.isNumeric = false})
      : super(key: key);

  final TextEditingController controller;
  final hintText;
  final isNumeric;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.textFieldHeight,
      width: double.infinity,
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text),
    );
  }
}
