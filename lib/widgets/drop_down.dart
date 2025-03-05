import 'package:flutter/material.dart';
import 'package:nutrimove/themes/theme.dart';

class MyDropdownField<T> extends StatelessWidget {
  final String title;
  final String hint;
  final List<T> items;
  final T selectedValue;
  final Function(T?) onChanged;

  const MyDropdownField({
    required this.title,
    required this.hint,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(title, style: titleStyle),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          padding: EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: selectedValue,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              style: TextStyle(fontSize: 16, color: Colors.black),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<T>>((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(value.toString()), 
                );
              }).toList(),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
