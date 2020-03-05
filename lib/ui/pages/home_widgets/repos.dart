import 'package:flutter/material.dart';

class ReposWidget extends StatefulWidget {
  @override
  _ReposWidgetState createState() => _ReposWidgetState();
}

class _ReposWidgetState extends State<ReposWidget> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Repos'),
      ),
      body: _buildList(),
    );
  }
}
