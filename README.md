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
<img src="" width="200" height="400" />

#### Tab trang chủ
<img src="https://private-user-images.githubusercontent.com/79151156/292736967-c815f13a-2001-449b-8043-d39e936a04fe.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDM0OTQ4NzksIm5iZiI6MTcwMzQ5NDU3OSwicGF0aCI6Ii83OTE1MTE1Ni8yOTI3MzY5NjctYzgxNWYxM2EtMjAwMS00NDliLTgwNDMtZDM5ZTkzNmEwNGZlLmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjI1VDA4NTYxOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWM3MmRmNWI1ODU2MDBlYjc3ZjcxMDk1Nzc5YzBkODVjODY0YWM0OWUxNmVkNWJiYzAwNmUzZjAxNGIwMGVhYTAmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.aqTdIyXfh51Th4kGrWle4xnNEQEMW6Uz39eAyfj6yCg" width="200" height="400" />

#### Tab bạn bè
<img src="https://private-user-images.githubusercontent.com/79151156/292737577-37e37dbe-90f3-42e9-8a0e-893574f0d245.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDM0OTUxODQsIm5iZiI6MTcwMzQ5NDg4NCwicGF0aCI6Ii83OTE1MTE1Ni8yOTI3Mzc1NzctMzdlMzdkYmUtOTBmMy00MmU5LThhMGUtODkzNTc0ZjBkMjQ1LmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjI1VDA5MDEyNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTZhOTRiMjJkNTYxNDk5YjAwNTVhZjE4MzUyNGUzZWU2MmY3MjY4MDQ3NTg2OWMyZjNkMDZjOWMwMDJmZjE3OGYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.CCn-1l-rg-oZ7HwO-QCjvR_JYznkukW23Tt0QtagU2s" width="200" height="400" />
<img src="https://private-user-images.githubusercontent.com/79151156/292738531-9d33ffe0-5190-4596-ab71-90b156f715b6.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDM0OTUzMTksIm5iZiI6MTcwMzQ5NTAxOSwicGF0aCI6Ii83OTE1MTE1Ni8yOTI3Mzg1MzEtOWQzM2ZmZTAtNTE5MC00NTk2LWFiNzEtOTBiMTU2ZjcxNWI2LmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjI1VDA5MDMzOVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWZiMDFmYTJiNTgzYzJlY2E5ZWIwMDhmYTYzMzc4YzhjMzhmYTVmOGNmZWE0YzUxMTEzMTNjYmQ0MGM2ZTBkNDQmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.91wnTbYh_Okp7k-DJ-6b9WU-E_gG4Y1NlH59lhtO7bc" width="200" height="400" />
<img src="https://private-user-images.githubusercontent.com/79151156/292738578-3371107c-5833-48e3-ab47-750f8d7d006f.jpg?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDM0OTUzNDgsIm5iZiI6MTcwMzQ5NTA0OCwicGF0aCI6Ii83OTE1MTE1Ni8yOTI3Mzg1NzgtMzM3MTEwN2MtNTgzMy00OGUzLWFiNDctNzUwZjhkN2QwMDZmLmpwZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjI1VDA5MDQwOFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTBlZmE5YjdhMzRjNjU2MDBjZTQ4ZjkwMDM4YzQ2YWUxMjcxMTUwY2U5NWVjMGFhNDdlNWM3NGViZjk0Y2ZiN2MmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.qZfuMboTwFMfDRdz-uYVLEVUJTIpXUTFxXSn4uUoJP8" width="200" height="400" />

