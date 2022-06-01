import 'package:flutter/material.dart';

// Multi Select widget
// This widget is reusable
class MultiSelect extends StatefulWidget {
  final List<String> items;
  final List<String> selected;

  const MultiSelect({Key? key, required this.items, required this.selected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        widget.selected.add(itemValue);
      } else {
        widget.selected.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select categories'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: widget.selected.contains(item),
                    title: Text(item),
                    checkColor: Colors.black,
                    activeColor: Colors.amber,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.black,
            ),
          ),
          onPressed: _cancel,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.amber),
          child: const Text(
            'Submit',
            style: TextStyle(
              fontFamily: 'Lato',
              color: Colors.black,
            ),
          ),
          onPressed: _submit,
        ),
      ],
    );
  }
}
