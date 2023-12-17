import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/my_widgets/bottom_nav_bar.dart';
import 'package:facebook_app/my_widgets/error_when_get_data_screen.dart';
import 'package:facebook_app/my_widgets/waiting_data_screen.dart';
import 'package:facebook_app/pages/auth/login/login_with_unknown_account.dart';
import 'package:facebook_app/pages/authenticated/chat/chat_screen.dart';
import 'package:facebook_app/pages/authenticated/friend/request_friends_page.dart';
import 'package:facebook_app/pages/authenticated/home_page.dart';
import 'package:facebook_app/pages/authenticated/menu.dart';
import 'package:facebook_app/pages/authenticated/notifications.dart';
import 'package:facebook_app/pages/authenticated/video/video_page.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/services/video_player_provider.dart';
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

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(email: "fdgdfgdfg"),
    const RequestFriendsPage(),
    const VideoPage(),
    const NotificationPage(),
    const Menu(),
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
    final _videoPlayerProvider = Provider.of<VideoPlayerProvider>(context, listen: false);

    FirebaseMessaging.instance.subscribeToTopic(_appService.uidLoggedIn);
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onTap: (index) {
          _onItemTapped(index);
          if (index == 2) {
            _videoPlayerProvider.setIsInVideoPage(true);
          } else {
            _videoPlayerProvider.setIsInVideoPage(false);
          }
        },
        index: _selectedIndex,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_appService.uidLoggedIn)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErrorGettingDataScreen();
            }
            if (snapshot.hasData &&
                snapshot.data!['device_id'] == _appService.deviceId) {
              return IndexedStack(
                index: _selectedIndex,
                children: _widgetOptions,
              );
              // _widgetOptions.elementAt(_selectedIndex);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const WaitingDataScreen();
            }
            _authService.logOut(context: context, isShowSnackbar: true);
            return const LogInUnknownPage();
          }),
    );
  }
}