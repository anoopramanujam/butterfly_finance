import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MyTextField extends StatelessWidget {
  MyTextField({Key? key, this.hintText = '', required this.controller})
      : super(key: key);

  final TextEditingController controller;
  final hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.textFieldHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Constants.paddingWidth,
            vertical: Constants.paddingHeight),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
