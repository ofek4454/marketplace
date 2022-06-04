import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Color? suffixColor;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          suffixColor = hasFocus ? Colors.amber : null;
        });
      },
      child: TextField(
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
          // TODO: search
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.amber,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: suffixColor,
          ),
        ),
      ),
    );
  }
}
