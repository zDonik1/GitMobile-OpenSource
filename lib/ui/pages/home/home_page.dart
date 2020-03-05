import 'package:flutter/material.dart';
import 'package:git_mobile/ui/pages/home_widgets/repos.dart';
import 'package:git_mobile/ui/resources/app_colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Text _appBarTitle = _navigationBarItems[0].title;

  Repos reposWidget = Repos();

  static const List<BottomNavigationBarItem> _navigationBarItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text('Repos'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add),
      title: Text('Create Repo'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      title: Text('Profile'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _appBarTitle = _navigationBarItems[index].title;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.gitHubSelectedItemColor,
        onTap: _onItemTapped,
      ),
      body: reposWidget,
    );
  }
}
