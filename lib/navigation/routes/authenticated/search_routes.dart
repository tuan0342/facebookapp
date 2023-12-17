import 'package:facebook_app/pages/authenticated/search/search_logs_page.dart';
import 'package:facebook_app/pages/authenticated/search/search_page.dart';
import 'package:go_router/go_router.dart';

final searchRoutes = GoRoute(
    path: "search",
    builder: (context, state) => const SearchPage(),
    routes: [searchLogsRoute]);

final GoRoute searchLogsRoute = GoRoute(
  path: 'logs',
  builder: (context, state) => const SearchLogsPage(),
);
