import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({super.key});

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(title: 'Điều khoản dịch vụ'),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Column(
                    children: [
                      Text(
                        'AntiFacebook xây dựng các công nghệ và dịch vụ cho phép mọi người kết nối với nhau, xây dựng cộng đồng và phát triển doanh nghiệp. Các Điều khoản này chi phối việc bạn sử dụng Facebook, Messenger và các sản phẩm, tính năng, ứng dụng, dịch vụ, công nghệ và phần mềm khác mà chúng tôi cung cấp (Sản phẩm Meta hoặc Sản phẩm ), trừ khi chúng tôi tuyên bố rõ ràng rằng các điều khoản riêng biệt (và không áp dụng các điều khoản này). Những Sản phẩm này do Meta Platforms, Inc. cung cấp cho bạn.',
                        style: TextStyle(fontSize: 18, height: 1.6),
                      ),
                      SizedBox(height: 30,),
                      Text(
                        'Chúng tôi không bán dữ liệu cá nhân của bạn cho nhà quảng cáo và chúng tôi không chia sẻ thông tin nhận dạng trực tiếp bạn (chẳng hạn như tên, địa chỉ email hoặc thông tin liên hệ khác) với nhà quảng cáo trừ khi bạn cho phép chúng tôi cụ thể. Thay vào đó, nhà quảng cáo có thể cho chúng tôi biết những thông tin như loại đối tượng họ muốn xem quảng cáo của mình và chúng tôi hiển thị những quảng cáo đó cho những người có thể quan tâm. Chúng tôi cung cấp cho nhà quảng cáo các báo cáo về hiệu suất quảng cáo của họ để giúp họ hiểu cách mọi người tương tác với nội dung của họ. Xem Phần 2 bên dưới để tìm hiểu thêm về cách hoạt động của quảng cáo được cá nhân hóa theo các điều khoản này trên Meta Products. Chính sách quyền riêng tư của chúng tôi giải thích cách chúng tôi thu thập và sử dụng dữ liệu cá nhân của bạn để xác định một số quảng cáo bạn nhìn thấy và cung cấp tất cả các dịch vụ khác được mô tả bên dưới. Bạn cũng có thể truy cập các trang cài đặt của Meta Product có liên quan bất cứ lúc nào để xem lại các lựa chọn về quyền riêng tư mà bạn có về cách chúng tôi sử dụng dữ liệu của bạn.',
                        style: TextStyle(fontSize: 18, height: 1.6),
                      ),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}