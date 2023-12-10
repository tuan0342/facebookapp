class NotificationModel {
  final String title;
  final String message;
  Map<String, dynamic>? data;

  NotificationModel({required this.title, required this.message, this.data});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "message": message,
      "data": data,
    };
  }
}
