import 'package:flutter/material.dart';
import '../../utils/constants.dart';

// Single selection only
class MyToggleButton extends StatefulWidget {
  const MyToggleButton({
    Key? key,
    required this.toggleItems,
    required this.onPressed,
    required this.selectedItem,
  }) : super(key: key);

  final List<Map> toggleItems;
  final Function onPressed;
  final String selectedItem;

  @override
  _MyToggleButtonState createState() => _MyToggleButtonState();
}

class _MyToggleButtonState extends State<MyToggleButton> {
  final List<Widget> _toggleItems = [];
  final List<bool> _selections = [];

  @override
  void initState() {
    super.initState();

    widget.toggleItems.forEach((toggleItem) {
      _toggleItems.add(SizedBox(
          width: Constants.toggleWidth,
          child: Center(
              child: Text(
            toggleItem['title'],
          ))));
      _selections.add(
          toggleItem['value'].toString() == widget.selectedItem ? true : false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(Constants.toggleRadius),
      children: _toggleItems,
      isSelected: _selections,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _selections.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              _selections[buttonIndex] = true;
            } else {
              _selections[buttonIndex] = false;
            }
          }
        });
        widget.onPressed(widget.toggleItems[index]['value']);
      },
    );
  }
}
