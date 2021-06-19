import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class TransactionScreen extends StatelessWidget {
  //const TransactionRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.titleTransaction),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  label: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MyButton(
                  label: 'Save',
                  onPressed: () {},
                ),
              ],
            )
          ],
        ));
  }
}

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
