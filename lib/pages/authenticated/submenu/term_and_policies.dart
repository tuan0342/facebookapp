import 'package:facebook_app/models/webview_model.dart';
import 'package:facebook_app/my_widgets/button_submenu.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class TermAndPolicies extends StatefulWidget {
  const TermAndPolicies({super.key});

  @override
  State<TermAndPolicies> createState() => _TermAndPoliciesState();
}

class _TermAndPoliciesState extends State<TermAndPolicies> {
  final WebView webViewTermAndPolicies = const WebView(titleOfAppBar: 'Tiêu chuẩn cộng đồng', uri: 'https://transparency.fb.com/vi-vn/policies/community-standards/?source=https%3A%2F%2Fm.facebook.com%2Fcommunitystandards');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Điều khoản & chính sách"),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const ButtonSubmenu(title: 'Điều khoản dịch vụ', icon: 'assets/images/terms_and_services_icon.png', 
                description: 'Điều khoản bạn đồng ý khi sử dụng Facebook', 
                route: '/authenticated/menu/termAndPolicies/termsOfService'),

              const ButtonSubmenu(title: 'Chính sách và quyền riêng tư', icon: 'assets/images/policy_and_privacy_icon.png', 
                description: 'Thông tin chúng tôi nhận và cách sử dụng', 
                route: '/authenticated/menu/termAndPolicies/policyAndPrivacy'),

              ButtonSubmenu(title: 'Tiêu chuẩn cộng đồng', icon: 'assets/images/community_standards_icon.png', 
                description: 'Điều không được phép và cách báo cáo hành vi lăng mạ/lạm dụng/ngược đãi', 
                route: '/authenticated/webViewContainer', webView: webViewTermAndPolicies),
            ],
          ),
        )
      ),
    );
  }
}