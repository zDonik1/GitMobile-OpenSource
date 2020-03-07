import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final String placeholder;
  final Color backgroundColor;

  SearchBox(this.placeholder, this.backgroundColor);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size.fromHeight(40)),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          filled: true,
          hintText: widget.placeholder,
          fillColor: widget.backgroundColor,
        ),
      ),
    );
  }
}
