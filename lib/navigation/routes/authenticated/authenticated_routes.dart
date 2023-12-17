import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/models/webview_model.dart';
import 'package:facebook_app/navigation/authenticated_navigator.dart';
import 'package:facebook_app/navigation/routes/authenticated/submenu_route.dart';
import 'package:facebook_app/navigation/routes/authenticated/search_routes.dart';
import 'package:facebook_app/pages/authenticated/chat/dialog_chat_screen.dart';
import 'package:facebook_app/pages/authenticated/personal/edit_personal_info_page.dart';
import 'package:facebook_app/pages/authenticated/personal/setting_personal_page.dart';
import 'package:facebook_app/pages/authenticated/chat/camera_screen.dart';
import 'package:facebook_app/pages/authenticated/chat/chat_my_profile.dart';
import 'package:facebook_app/pages/authenticated/chat/chat_screen.dart';
import 'package:facebook_app/pages/authenticated/chat/new_conversation.dart';
import 'package:facebook_app/pages/authenticated/friend/suggest_friends_page.dart';
import 'package:facebook_app/pages/authenticated/friend/user_friends_page.dart';
import 'package:facebook_app/pages/authenticated/personal_page.dart';
import 'package:facebook_app/pages/authenticated/video/full_screen_video_page.dart';
import 'package:facebook_app/pages/webview/webview_container.dart';
import 'package:go_router/go_router.dart';

import '../../../pages/authenticated/chat/camera_screen.dart';
import '../../../pages/authenticated/chat/chat_my_profile.dart';
import '../../../pages/authenticated/chat/chat_screen.dart';
import '../../../pages/authenticated/chat/new_conversation.dart';

final GoRoute authenticatedRoute = GoRoute(
  path: '/authenticated',
  builder: (context, state) => const AuthenticatedNavigator(),
  routes: [
    searchRoutes,
    menuRoute,
    GoRoute(
      path: 'personalPage/:uid',
      builder: (context, state) => PersonalPage(uid: state.pathParameters["uid"]!,),
      routes: [
        GoRoute(
          path: "settingPersonalPage",
          builder: (context, state) {
            Profile profile = state.extra as Profile;
            return SettingPersonalPage(profile: profile);
            
          }
        ),
        GoRoute(
          path: "editPersonalInfoPage",
          builder: (context, state) {
            Profile profile = state.extra as Profile;
            return EditPersonalInfoPage(profile: profile);
          }
        ),
      ]
    ),
    GoRoute(
      path: "friends/suggests",
      builder: (context, state) => const SuggestFriendsPage()),
    GoRoute(
      path: "friends",
      builder: (context, state) => const UserFriendsPage()),
    GoRoute(
      path: "webViewContainer",
      builder: (context, state) {
        WebView webView = state.extra as WebView;
        return WebViewContainer(webView: webView,);
      },
    ),
    GoRoute(
      path: "takePhoto",
      builder: (context, state) => const TakePictureScreen(),
    ),
    GoRoute(
      path: "chat/:uid",
      builder: (context, state) {
        final id = state.pathParameters["uid"]!;
        return DialogChatScreen(friendUid: id);
      },
    ),
    GoRoute(
      path: "chatMyProfile",
      builder: (context, state) => const ChatMyProfile(),
    ),
    GoRoute(
      path: "newConversation",
      builder: (context, state) => const NewConversation(),
    ),
    GoRoute(
      path: "fullScreenVideo",
      builder: (context, state) => const FullScreenVideoPage(),
    ),
  ],
  redirect: (context, state) {
    return null;
  },
);

