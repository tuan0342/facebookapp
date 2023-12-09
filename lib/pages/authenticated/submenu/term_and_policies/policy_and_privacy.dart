import 'package:facebook_app/models/webview_model.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PolicyAndPrivacy extends StatefulWidget {
  const PolicyAndPrivacy({super.key});

  @override
  State<PolicyAndPrivacy> createState() => _PolicyAndPrivacyState();
}

class _PolicyAndPrivacyState extends State<PolicyAndPrivacy> { 
  final WebView webViewPrintableVersion = const WebView(titleOfAppBar: 'Chính sách bảo mật', uri: 'https://mbasic.facebook.com/privacy/policy/printable/');
  final WebView webViewPreVersions = const WebView(titleOfAppBar: 'Chính sách bảo mật', uri: 'https://mbasic.facebook.com/privacy/policy/printable/');
  final WebView webViewProducts = const WebView(titleOfAppBar: 'Chính sách bảo mật', uri: 'https://mbasic.facebook.com/privacy/policy/printable/');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: 'Chính sách và quyền riêng tư'),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Chính sách bảo mật',
                        style: TextStyle(fontSize: 24, height: 1.6, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        'Chính sách quyền riêng tư là gì và nó bao gồm những gì?',
                        style: TextStyle(fontSize: 24, height: 1.6, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 20,),
                      RichText(
                        text: TextSpan(
                          text: 'Có hiệu lực từ ngày 15 tháng 6 năm 2023 | ',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {
                                context.push('/authenticated/webViewContainer', extra: webViewPreVersions);
                              },
                              text: 'Xem bản tin được | ',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {
                                context.push('/authenticated/webViewContainer', extra: webViewPrintableVersion);
                              },
                              text: 'Xem các phiên bản trước',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      RichText(
                        text: TextSpan(
                          text: 'Tại Meta, chúng tôi muốn bạn hiểu những thông tin chúng tôi thu thập cũng như cách chúng tôi sử dụng và chia sẻ thông tin đó. Đó là lý do tại sao chúng tôi khuyến khích bạn đọc Chính sách quyền riêng tư của chúng tôi. Điều này giúp bạn sử dụng ',
                          style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () {
                                context.push('/authenticated/webViewContainer', extra: webViewProducts);
                              },
                              text: 'Sản phẩm Anti Facebook',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            const TextSpan(
                              text: ' theo cách phù hợp với bạn.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),

                      const Text(
                        'Trong Chính sách quyền riêng tư, chúng tôi giải thích cách chúng tôi thu thập, sử dụng, chia sẻ, lưu giữ và chuyển giao thông tin. Chúng tôi cũng cho bạn biết quyền của bạn. Mỗi phần của Chính sách bao gồm các ví dụ hữu ích và ngôn ngữ đơn giản hơn để giúp các thông lệ của chúng tôi dễ hiểu hơn. Chúng tôi cũng đã thêm các liên kết tới các tài nguyên nơi bạn có thể tìm hiểu thêm về các chủ đề bảo mật mà bạn quan tâm.',
                        style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
                      ),
                      const SizedBox(height: 20,),

                      RichText(
                        text: const TextSpan(
                          text: 'Điều quan trọng đối với chúng tôi là bạn biết cách kiểm soát quyền riêng tư của mình, vì vậy, chúng tôi cũng chỉ cho bạn nơi bạn có thể quản lý thông tin của mình trong cài đặt của Sản phẩm Meta mà bạn sử dụng. Bạn có thể ',
                          style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
                          children: [
                            TextSpan(
                              text: ' cập nhật các cài đặt này ',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: 'để định hình trải nghiệm của mình.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),

                      const Text(
                        'Điều gì sẽ xảy ra nếu bạn không cho phép chúng tôi thu thập một số thông tin nhất định?',
                        style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        'Một số thông tin là bắt buộc để Sản phẩm của chúng tôi hoạt động. Các thông tin khác là tùy chọn nhưng nếu không có thông tin đó, chất lượng trải nghiệm của bạn có thể bị ảnh hưởng.',
                        style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
                      ),
                      const SizedBox(height: 20,),

                      const Text(
                        'Điều gì sẽ xảy ra nếu thông tin chúng tôi thu thập không xác định được danh tính cá nhân?',
                        style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        'Trong một số trường hợp, thông tin được các bên thứ ba hủy nhận dạng, tổng hợp hoặc ẩn danh để thông tin đó không còn nhận dạng các cá nhân trước khi được cung cấp cho chúng tôi. Chúng tôi sử dụng thông tin này như được mô tả bên dưới mà không cố gắng xác định lại các cá nhân.',
                        style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}