import 'package:flutter/material.dart';
import 'package:git_mobile/presentation/widgets/search_widget.dart';

class ReposWidget extends StatefulWidget {
  @override
  _ReposWidgetState createState() => _ReposWidgetState();
}

class _ReposWidgetState extends State<ReposWidget> {
  // State
  bool _isSearching = false;
  double _searchTextFieldOpacity = 0.0;
  double _titleOpacity = 1.0;

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

  void _onSearchPressed() {
    print('Search Tapped');
    setState(() {
      _searchTextFieldOpacity = 1.0;
      _titleOpacity = 0.0;
      _isSearching = true;
    });
  }

  void _onCancelPressed() {
    print('Cancel Tapped');
    setState(() {
      _searchTextFieldOpacity = 0.0;
      _titleOpacity = 1.0;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedCrossFade(
          duration: Duration(milliseconds: 100),
          firstChild: SearchBox('Repository name', Colors.white),
          secondChild: Text('Search '
              'Repositories'),
          crossFadeState: _isSearching
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
        actions: <Widget>[
          _isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.white,
                  onPressed: _onCancelPressed,
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: _onSearchPressed,
                ),
        ],
      ),
      body: _buildList(),
    );
  }
}
