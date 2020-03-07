import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Card _profileCard = Card(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[Text('@nickname')],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 100,
                  child: _profileCard,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
