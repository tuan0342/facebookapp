import 'package:facebook_app/pages/auth/create_account/add_email_page.dart';
import 'package:facebook_app/pages/auth/create_account/choosing_birthday_page.dart';
import 'package:facebook_app/pages/auth/create_account/confirm_code_page.dart';
import 'package:facebook_app/pages/auth/create_account/join_facebook_page.dart';
import 'package:facebook_app/pages/auth/create_account/naming_page.dart';
import 'package:facebook_app/pages/auth/create_account/term_of_service_page.dart';
import 'package:facebook_app/pages/auth/register/register_page.dart';
import 'package:facebook_app/pages/auth/register/verify_account_page.dart';
import 'package:go_router/go_router.dart';

final GoRoute registerRoute = GoRoute(
      path: 'register',
      builder: (context, state) => const RegisterPage(),
      routes: [
        GoRoute(
          path: 'confirmCode/:email',
          builder: (context, state) => VerifyAccountPage(email: state.pathParameters["email"]!,),
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