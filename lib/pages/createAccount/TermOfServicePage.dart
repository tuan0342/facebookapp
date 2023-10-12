import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_date_picker.dart';
import 'package:facebook_app/my_widgets/my_editText.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermOfServicePage extends StatelessWidget {
  const TermOfServicePage({super.key});


  @override
  Widget build(BuildContext context) {
    void nextScreen() {
      context.push("/createAccount/email");
    }

    return Scaffold(
      appBar: MyAppBar(title: "Điều khoản và quyền riêng tư"),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: MyText(title: "Hoàn tất đăng kí?", type: "title",),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 24, 16.0, 0),
                    child: MyText(title: "Bằng cách nhấn vào Đăng ký, bạn đồng ý với Điều khoản, Chính sách dữ liệu và Chính sách cookie của chúng tôi. Bạn có thể nhận được thông báo của chúng tôi qua SMS và chọn không nhận bất cứ lúc nào. Thông tin từ danh bạ của bạn sẽ được tải lên Facebook liên tục để chúng tôi có thể gợi ý bạn bè, cung cấp và cải thiện quảng cáo cho bạn và người khác, cũng như mang đến dịch vụ tốt hơn.", type: "label",),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: MyFilledButton(title: "Đăng ký", isDisabled: false, cbFunction: nextScreen),
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: MyTextButton(title: "Đăng ký mà không tải danh bạ tôi lên", isDisabled: false, cbFunction: nextScreen),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8, 16.0, 8,),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MyText(title: "Thông tin liên hệ trong danh bạ của bạn, bao gồm tên, số điện thoại và biệt danh, sẽ được gửi tới Facebook để chúng tôi có thể gợi ý bạn bè, cung cấp và cải thiện quảng cáo cho bạn và người khác, cũng như mang đến dịch vụ tốt hơn. Bạn có thể tắt tính năng này trong phần Cài đặt, quản lý hoặc xóa bỏ thông tin liên hệ mình đã chia sẻ với Facebook. Tìm hiểu thêm", type: "label",)
              ),
            )
          ],
        ),
      ),
    );
  }
}