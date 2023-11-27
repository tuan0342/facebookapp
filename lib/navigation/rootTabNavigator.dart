import 'package:facebook_app/my_widgets/bottom_nav_bar.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/pages/Friends.dart';
import 'package:facebook_app/pages/homePage.dart';
import 'package:flutter/material.dart';

class RootTabNavigator extends StatefulWidget {
  const RootTabNavigator({super.key});

  @override
  State<RootTabNavigator> createState() => _RootTabNavigatorState();
}

class _RootTabNavigatorState extends State<RootTabNavigator> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
       HomePage(
        email: "Nguyen Van Tam",
      ),
      Friends(),
      const Text(
        'List notify',
        style: optionStyle,
      ),
            const Text(
        'Menu',
        style: optionStyle,
      ),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(onTap: _onItemTapped, index: _selectedIndex,)
    );
  }
}
