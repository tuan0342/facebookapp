import 'package:facebook_app/pages/authenticated/menu.dart';
import 'package:facebook_app/pages/authenticated/submenu/login_security.dart';
import 'package:facebook_app/pages/authenticated/submenu/login_security_change_password.dart';
import 'package:facebook_app/pages/authenticated/submenu/personal_information.dart';
import 'package:facebook_app/pages/authenticated/submenu/personal_name.dart';
import 'package:facebook_app/pages/authenticated/submenu/policy_and_privacy.dart';
import 'package:facebook_app/pages/authenticated/submenu/setting.dart';
import 'package:facebook_app/pages/authenticated/submenu/term_and_policies.dart';
import 'package:facebook_app/pages/authenticated/submenu/terms_of_service.dart';
import 'package:go_router/go_router.dart';

final GoRoute menuRoute = GoRoute(
  path: 'menu',
  builder: (context, state) => const Menu(),
  routes: [
    termRoute,
    settingRoute,
  ]
);

final GoRoute termRoute =  GoRoute(
  path: 'termAndPolicies',
  builder: (context, state) => const TermAndPolicies(),
  routes: [
    GoRoute(
      path: 'termsOfService',
      builder: (context, state) => const TermsOfService(),
    ),
    GoRoute(
      path: 'policyAndPrivacy',
      builder: (context, state) => const PolicyAndPrivacy(),
    ),
  ]
);

final GoRoute settingRoute = GoRoute(
  path: 'setting',
  builder: (context, state) => const Setting(),
  routes: [
    GoRoute(
      path: 'personalInformation',
      builder: (context, state) => const PersonalInformation(),
      routes: [
        GoRoute(
          path: 'personalName',
          builder: (context, state) => const PersonalName(),
        ),
      ]
    ),
    GoRoute(
      path: 'loginSecurity',
      builder: (context, state) => const LoginSecurity(),
      routes: [
        GoRoute(
          path: 'changePassword',
          builder: (context, state) => const LoginSecurityChangePassword(),
        ),
      ]
    ),
  ]
);