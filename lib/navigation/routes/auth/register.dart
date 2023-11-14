import 'package:facebook_app/pages/auth/create_account/add_email_page.dart';
import 'package:facebook_app/pages/auth/create_account/choosing_birthday_page.dart';
import 'package:facebook_app/pages/auth/create_account/confirm_code_page.dart';
import 'package:facebook_app/pages/auth/create_account/join_facebook_page.dart';
import 'package:facebook_app/pages/auth/create_account/naming_page.dart';
import 'package:facebook_app/pages/auth/create_account/term_of_service_page.dart';
import 'package:facebook_app/pages/auth/register/register_page.dart';
import 'package:go_router/go_router.dart';

final GoRoute registerRoute = GoRoute(
      path: 'register',
      builder: (context, state) => const RegisterPage(),
      routes: [
        GoRoute(
          path: 'joinFacebook',
          builder: (context, state) => const JoinFacebookPage(),
        ),
        GoRoute(
          path: 'name',
          builder: (context, state) => const NamingPage(),
        ),
        GoRoute(
          path: 'birthdate',
          builder: (context, state) => const ChoosingBirthdayPage(),
        ),
        GoRoute(
          path: 'termOfService',
          builder: (context, state) => const TermOfServicePage(),
        ),
        GoRoute(
          path: 'email',
          builder: (context, state) => const AddEmailPage(),
        ),
        GoRoute(
          path: 'confirmCode',
          builder: (context, state) => const ConfirmCodePage(),
        ),
        // GoRoute(
        //   path: 'allDone',
        //   builder: (context, state) => const MyApp(),
        // ),
      ]
);
//
// class CreateAccountNavigator extends StatelessWidget {
//   const CreateAccountNavigator({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: _router
//     );
//   }
// }