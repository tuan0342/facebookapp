import 'package:facebook_app/main.dart';
import 'package:facebook_app/pages/createAccount/AddEmailPage.dart';
import 'package:facebook_app/pages/createAccount/ChoosingBirthdayPage.dart';
import 'package:facebook_app/pages/createAccount/ConfirmCodePage.dart';
import 'package:facebook_app/pages/createAccount/JoinFacebookPage.dart';
import 'package:facebook_app/pages/createAccount/NamingPage.dart';
import 'package:facebook_app/pages/createAccount/TermOfServicePage.dart';
import 'package:go_router/go_router.dart';

final GoRoute createAccountRoute = GoRoute(
      path: '/createAccount',
      builder: (context, state) => const JoinFacebookPage(),
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