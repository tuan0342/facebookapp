import 'package:facebook_app/main.dart';
import 'package:facebook_app/pages/createAccount/AddEmailPage.dart';
import 'package:facebook_app/pages/createAccount/ChoosingBirthdayPage.dart';
import 'package:facebook_app/pages/createAccount/ConfirmCodePage.dart';
import 'package:facebook_app/pages/createAccount/JoinFacebookPage.dart';
import 'package:facebook_app/pages/createAccount/NamingPage.dart';
import 'package:facebook_app/pages/createAccount/TermOfServicePage.dart';
import 'package:facebook_app/pages/db/AddStudent.dart';
import 'package:facebook_app/pages/db/TableStudent.dart';
import 'package:go_router/go_router.dart';

final GoRoute studentRoute = GoRoute(
    path: '/students',
    builder: (context, state) => const StudentsTable(),
    routes: []
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