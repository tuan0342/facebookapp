import 'package:facebook_app/my_widgets/bottom_nav_bar.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/pages/authenticated/friends.dart';
import 'package:facebook_app/pages/authenticated/home_page.dart';
import 'package:facebook_app/pages/authenticated/menu.dart';
import 'package:flutter/material.dart';

class TestAuthenticatedNavigator extends StatefulWidget {
  const TestAuthenticatedNavigator({super.key});

  @override
  State<TestAuthenticatedNavigator> createState() =>
      _TestAuthenticatedNavigatorState();
}

class _TestAuthenticatedNavigatorState extends State<TestAuthenticatedNavigator> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(
      email: "Nguyen Van Tam",
    ),
    Friends(),
    const Text(
      'List notify',
      style: optionStyle,
    ),
    // const Text(
    //   'Menu',
    //   style: optionStyle,
    // ),
    const Menu()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () { },
            icon: const Icon(Icons.logout))
          ],
        ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        onTap: _onItemTapped,
        index: _selectedIndex,
      )
    );
  }
}
