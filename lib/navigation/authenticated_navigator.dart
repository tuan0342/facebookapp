import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/my_widgets/bottom_nav_bar.dart';
import 'package:facebook_app/pages/auth/login/login_with_unknown_account.dart';
import 'package:facebook_app/pages/authenticated/friends.dart';
import 'package:facebook_app/pages/authenticated/home_page.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthenticatedNavigator extends StatefulWidget {
  const AuthenticatedNavigator({super.key});

  @override
  State<AuthenticatedNavigator> createState() => _AuthenticatedNavigatorState();
}

class _AuthenticatedNavigatorState extends State<AuthenticatedNavigator> {
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
    final _appService = Provider.of<AppService>(context, listen: false);
    final _authService = Provider.of<AuthService>(context, listen: false);

    FirebaseMessaging.instance.subscribeToTopic(_appService.uidLoggedIn);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_appService.uidLoggedIn)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(body: Center(child: Text("Get error")));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: Text("Loading...")));
          }

          if (snapshot.hasData &&
              snapshot.data!['device_id'] == _appService.deviceId) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Home Page"),
                   actions: [
                    IconButton(
                        onPressed: () {
                          context.go("/authenticated/chat");
                        },
                        icon: const Icon(Icons.message_outlined)),
                    IconButton(
                        onPressed: () {
                          _authService.logOut(context: context);
                        },
                        icon: const Icon(Icons.logout))
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
          _authService.logOut(context: context, isShowSnackbar: true);
          return const LogInUnknownPage();
        });
  }
}
