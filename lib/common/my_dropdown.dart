import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown(
      {Key? key,
      required this.dropdownItems,
      required this.selectedValue,
      required this.onChanged})
      : super(key: key);

  final List<Map> dropdownItems;
  final String selectedValue;
  final Function onChanged;

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  late String selectedValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedValue = widget.selectedValue;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Colors.green.shade200,
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
        widget.onChanged(newValue!);
      },
      items: widget.dropdownItems.map<DropdownMenuItem<String>>((Map item) {
        return DropdownMenuItem<String>(
          value: item['value'].toString(),
          child: Text(item['title']),
        );
      }).toList(),
    );
  }
}
