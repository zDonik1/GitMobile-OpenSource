import 'package:flutter/material.dart';

class AddRepoWidget extends StatefulWidget {
  @override
  _AddRepoWidgetState createState() => _AddRepoWidgetState();
}

class _AddRepoWidgetState extends State<AddRepoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Repo'),
      ),
    );
  }
}
