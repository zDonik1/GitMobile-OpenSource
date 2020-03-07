import 'package:flutter/material.dart';
import 'package:git_mobile/presentation/pages/my_repos.dart';
import 'package:git_mobile/presentation/pages/profile.dart';
import 'package:git_mobile/presentation/pages/repos.dart';
import 'package:git_mobile/presentation/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Widget _selectedWidget = ReposWidget();

  static const List<BottomNavigationBarItem> _navigationBarItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text('Repos'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.view_list),
      title: Text('My Repos'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      title: Text('Profile'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          _selectedWidget = ReposWidget();
          break;
        case 1:
          _selectedWidget = AddRepoWidget();
          break;
        case 2:
          _selectedWidget = ProfileWidget();
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.gitHubSelectedItemColor,
        onTap: _onItemTapped,
      ),
      body: _selectedWidget,
    );
  }
}
