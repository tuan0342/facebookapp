import 'package:facebook_app/navigation/authenticated_navigator.dart';
import 'package:facebook_app/pages/authenticated/chat/camera_screen.dart';
import 'package:facebook_app/pages/authenticated/chat/chat_my_profile.dart';
import 'package:facebook_app/pages/authenticated/chat/chat_screen.dart';
import 'package:facebook_app/pages/authenticated/chat/new_conversation.dart';
import 'package:go_router/go_router.dart';

final GoRoute authenticatedRoute = GoRoute(
      path: '/authenticated',
      builder: (context, state) => const AuthenticatedNavigator(),
      routes: [
        GoRoute(
          path: "chat",
          builder: (context, state) => const ChatScreen(),
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
      ]
);
