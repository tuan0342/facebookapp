import 'package:facebook_app/pages/authenticated/submenu/setting_and_privacy/add_block_page.dart';
import 'package:facebook_app/pages/authenticated/menu.dart';
import 'package:facebook_app/pages/authenticated/submenu/setting_and_privacy/block_page.dart';
import 'package:facebook_app/pages/authenticated/submenu/setting_and_privacy/login_security.dart';
import 'package:facebook_app/pages/authenticated/submenu/setting_and_privacy/login_security_change_password.dart';
import 'package:facebook_app/pages/authenticated/submenu/setting_and_privacy/personal_information.dart';
import 'package:facebook_app/pages/authenticated/submenu/setting_and_privacy/personal_name.dart';
import 'package:facebook_app/pages/authenticated/submenu/term_and_policies/policy_and_privacy.dart';
import 'package:facebook_app/pages/authenticated/submenu/setting.dart';
import 'package:facebook_app/pages/authenticated/submenu/term_and_policies.dart';
import 'package:facebook_app/pages/authenticated/submenu/term_and_policies/terms_of_service.dart';
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
    GoRoute(
      path: 'block',
      builder: (context, state) => const BlockPage(),
      routes: [
        GoRoute(
          path: 'addBlock',
          builder: (context, state) => const AddBlockPage(),
        ),
      ]
    ),
  ]
);