
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/models/webview_model.dart';
import 'package:facebook_app/my_widgets/post/feed_item_detail.dart';
import 'package:facebook_app/navigation/authenticated_navigator.dart';
import 'package:facebook_app/navigation/routes/authenticated/submenu_route.dart';
import 'package:facebook_app/navigation/routes/authenticated/search_routes.dart';
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
import 'package:facebook_app/pages/feed/post/add_post.dart';
import 'package:facebook_app/pages/webview/webview_container.dart';
import 'package:go_router/go_router.dart';
import '../../../pages/feed/post/edit_post.dart';

import '../../../pages/authenticated/chat/camera_screen.dart';
import '../../../pages/authenticated/chat/chat_my_profile.dart';
import '../../../pages/authenticated/chat/chat_screen.dart';
import '../../../pages/authenticated/chat/new_conversation.dart';

final GoRoute authenticatedRoute = GoRoute(
  path: '/authenticated',

  routes: [
    searchRoutes,
    menuRoute,
    GoRoute(
        path: "addPost",
        builder: (context, state) => const PostPage(),

        ),
    GoRoute(
        path: "editPost",
        builder: (context, state) {
          Post post = state.extra as Post;
          return EditPost(postData: post);
        }
    ),
    GoRoute(
        path: "personalPage/:uid",
        builder: (context, state) => PersonalPage(
              uid: state.pathParameters["uid"]!,
            ),
        routes: [
          GoRoute(
              path: "settingPersonalPage",
              builder: (context, state) {
                Profile profile = state.extra as Profile;
                return SettingPersonalPage(profile: profile);
              }),
          GoRoute(
              path: "editPersonalInfoPage",
              builder: (context, state) {
                Profile profile = state.extra as Profile;
                return EditPersonalInfoPage(profile: profile);
              }),
        ]),
    GoRoute(
        path: "friends/suggests",
        builder: (context, state) => const SuggestFriendsPage()),
    GoRoute(
        path: "friends/:uid",
        builder: (context, state) =>
            UserFriendsPage(uid: state.pathParameters["uid"]!)),
    GoRoute(
      path: "webViewContainer",
      builder: (context, state) {
        WebView webView = state.extra as WebView;
        return WebViewContainer(
          webView: webView,
        );
      },
    ),
    GoRoute(
      path: "takePhoto",
      builder: (context, state) => const TakePictureScreen(),
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
    GoRoute(
      path: "postDetail/:id",
      builder: (context, state) =>
          FeedItemDetail(postId: state.pathParameters["id"]!)),
    GoRoute(
      path: ":index",
      builder: (context, state) {
        late int index;
        if (state.pathParameters["index"] == null) {
          index = 0;
        } else {
          index = int.parse(state.pathParameters["index"]!);
        }
        return AuthenticatedNavigator(
          selected: index,
        );
      },
    ),
  ],
  redirect: (context, state) {
    return null;
  },
);

