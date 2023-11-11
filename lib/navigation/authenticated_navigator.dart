import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/my_widgets/bottom_nav_bar.dart';
import 'package:facebook_app/pages/auth/login/login_with_unknown_account.dart';
import 'package:facebook_app/pages/authenticated/friends.dart';
import 'package:facebook_app/pages/authenticated/home_page.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticatedNavigator extends StatefulWidget {
  const AuthenticatedNavigator({super.key});

  @override
  State<AuthenticatedNavigator> createState() => _AuthenticatedNavigatorState();
}

class _AuthenticatedNavigatorState extends State<AuthenticatedNavigator> {
  int _selectedIndex = 0;
  void logOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    await authService.logout(context: context);
  }

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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(Provider.of<AuthService>(context, listen: false).uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Text("waiting"));
          }

          if (snapshot.hasData &&
              snapshot.data!['device_id'] ==
                  Provider.of<AuthService>(context, listen: false).deviceId) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Home Page"),
                  actions: [
                    IconButton(
                        onPressed: logOut, icon: const Icon(Icons.logout))
                  ],
                ),
                body: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
                bottomNavigationBar: BottomNavBar(
                  onTap: _onItemTapped,
                  index: _selectedIndex,
                ));
          }
          Provider.of<AuthService>(context, listen: false).shared.remove('uid');
          return const LogInUnknownPage();
        });
  }
}
