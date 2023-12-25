import 'package:facebook_app/pages/authenticated/search/search_logs_page.dart';
import 'package:facebook_app/pages/authenticated/search/search_page.dart';
import 'package:go_router/go_router.dart';

final searchRoutes = GoRoute(
  path: "search",
  routes: [
    searchLogsRoute,
    GoRoute(
      path: ':type',
      builder: (context, state) {
        String type;
        if (state.pathParameters["type"] == null ||
            state.pathParameters["type"] == "") {
          type = "post";
        } else {
          type = (state.pathParameters["type"]!);
        }
        return SearchPage(type: type);
      },
    ),
  ],
  redirect: (context, state) {
    return null;
  },
);

final GoRoute searchLogsRoute = GoRoute(
  path: 'logs',
  builder: (context, state) => const SearchLogsPage(),
);
