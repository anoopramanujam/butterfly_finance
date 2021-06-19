import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  final label;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Constants.buttonWidth,
      height: Constants.buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(label),
      ),
    );
  }
}
