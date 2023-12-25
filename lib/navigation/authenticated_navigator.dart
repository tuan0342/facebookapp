import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/my_widgets/bottom_nav_bar.dart';
import 'package:facebook_app/my_widgets/error_when_get_data_screen.dart';
import 'package:facebook_app/my_widgets/waiting_data_screen.dart';
import 'package:facebook_app/pages/auth/login/login_with_unknown_account.dart';
import 'package:facebook_app/pages/authenticated/chat/chat_screen.dart';
import 'package:facebook_app/pages/authenticated/friend/request_friends_page.dart';
import 'package:facebook_app/pages/feed/home_page.dart';
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
  final int selected;
  const AuthenticatedNavigator({super.key, this.selected = 0});

  @override
  State<AuthenticatedNavigator> createState() => _AuthenticatedNavigatorState();
}

class _AuthenticatedNavigatorState extends State<AuthenticatedNavigator> {
  late int _selectedIndex;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const RequestFriendsPage(),
    const VideoPage(),
    const NotificationPage(),
    const Menu(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.selected;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appService = Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final _videoPlayerProvider =
        Provider.of<VideoPlayerProvider>(context, listen: false);

    FirebaseMessaging.instance.subscribeToTopic(_appService.uidLoggedIn);
    if (_appService.subcribe.isNotEmpty &&
        _appService.subcribe != _appService.uidLoggedIn) {
      FirebaseMessaging.instance.unsubscribeFromTopic(_appService.subcribe);
      _appService.subcribe = _appService.uidLoggedIn;
    }
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text("Anti Facebook"),
              actions: [
                IconButton(
                    onPressed: () {
                      context.push("/authenticated/search/post");
                    },
                    icon: const Icon(Icons.search_rounded)),
              ],
            )
          : null,
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
            WidgetsBinding.instance.addPostFrameCallback((_) =>
                authService.logOut(context: context, isShowSnackbar: true));
            return const WaitingDataScreen();
          }),
    );
  }
}
