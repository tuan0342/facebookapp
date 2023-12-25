# facebook_app: Ứng dụng facebook

Project môn học Phát triển ứng dụng đa nền tảng - Đại học Bách Khoa Hà Nội - 2023.1

## Công nghệ sử dụng: Flutter

## Code conventions

### Nhánh:
- master: nhánh chính, luôn chạy được
- develope: nhánh để phát triển. Các thành viên trong nhóm tạo nhánh được checkout từ nhánh này để phát triển tính năng
- Mỗi thành viên trong nhóm sẽ tạo 1 nhánh riêng để phát triển tính năng.
  + Quy tắc đặt tên: Tên thành viên nhóm. VD: TuanNV, NamDH, LoiVV,...
  
### Note: merge nhánh
- B1: Nhánh của các thành viên sẽ được merge vào nhánh develope.
- B2: Sau khi test và không có lỗi sẽ được merge nhánh develope vào nhánh master.
- B3: Nếu có lỗi ở nhánh develope thì thành viên nhóm sẽ pull code và sửa lỗi tại nhánh của mình. Sửa xong sẽ được merge vào develope và tiếp tục test. Không có lỗi sẽ được merge vào nhánh master

### Đặt tên
- Tên folder, tên file: viết thường, sử dụng ký tự '_' giữa các từ. Eg: folder_name, file_name
- Tên hàm, tên biến: sử dụng quy tắc camelCase. Eg: methodName, varName
- Tên class: CamelCase: eg: ClassName

## Explain some feature
### Router
- Gồm 3 route chính: 
  + '/': Splash screen (khi đang khởi tạo ứng dụng)
  + '/auth': Các auth screen (Sử dụng với các màn chức năng authen, ví dụ: đăng nhập, đăng ký, ..)
  + '/authenticated': Các màn hình sau khi đã xác thực người dùng (authenticated) (Ví dụ: Home, Noti, ...)

### Call api
- Sử dụng các Rest method trong file "rest_api.dart" trong folder "rest_api"  
- Sử dụng method handle_response trong folder "rest_api" để sử lý response từ api

### Service
- chung: 
  + các service extends "ChangeNotifier" và được "Provide" tại hàm build của app_navigator
  + khi muốn sử dụng các biến, hàm của các service: tạo 1 biến tại nơi muốn sử dụng bằng cách gọi **Provider.of<"Service">(context, listen: false);** để lấy instance của service và sử dụng
- các services:
  + appService: hold app state(props)
  + authService: gồm các hàm sử lý authen
  + notificationServices: gồm các hàm sử lý push noti


## Thành viên nhóm:
- Ngô Văn Tuấn - 20200559
- Phạm Thị Hồng Hạnh - 20204546
- Đỗ Hải Nam - 20204590
- Vũ Văn Lợi - 20204577
- Nguyễn Khánh Duy - 20204647

## Ảnh demo sản phẩm
#### Ảnh trang cá nhân
<img src="" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="200" height="400" />
