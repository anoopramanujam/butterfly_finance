import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown({Key? key, required this.dropdownItems}) : super(key: key);

  final List<Map> dropdownItems;

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  late String selectedValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedValue = (widget.dropdownItems
            .where((element) => element['isSelected'] == true)
            .first)['value']
        .toString();
  }

  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedValue = (widget.dropdownItems
            .where((element) => element['isSelected'] == true)
            .first)['value']
        .toString();
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
