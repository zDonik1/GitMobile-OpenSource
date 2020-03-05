import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

class Repos extends StatefulWidget {
  @override
  _ReposState createState() => _ReposState();
}

class _ReposState extends State<Repos> {
  Widget _buildList() => ListView(
        children: [
          _tile('RxSwift', 'RxSwiftCommunity', Icons.account_box),
          _tile('SnapKit', 'SnapKit', Icons.account_box),
          _tile('Alamofire', 'Some team', Icons.account_box),
          _tile('Swinject', 'Dependency Injection', Icons.account_box),
          _tile('RxDataSources', 'RxSwiftCommunity', Icons.account_box),
          _tile('IQKeyboardManagerSwift', 'hatalaku', Icons.account_box),
          _tile('Firebase', 'Google', Icons.account_box),
          _tile('SCLAlertView', 'coolperson123', Icons.account_box),
          _tile('PKHUD', 'hello321', Icons.account_box),
          _tile('RxReachability', 'RxSwiftCommunity', Icons.account_box),
        ],
      );

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildList(),
      ],
    );
  }
}
