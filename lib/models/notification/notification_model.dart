class ApiNotification {
  final String message;
  final String role;
  final String blmDibaca;
  final List<NotificationModel> result;

  ApiNotification({
    required this.message,
    required this.role,
    required this.blmDibaca,
    required this.result,
  });

  factory ApiNotification.fromJson(Map<String, dynamic> json) {
    return ApiNotification(
      message: json['message'],
      role: json['role'],
      blmDibaca: json['blm_dibaca'],
      result: (json['result'] as List)
          .map((i) => NotificationModel.fromJson(i))
          .toList(),
    );
  }
}

class NotificationModel {
  final int idNotif;
  final int userId;
  final int idPost;
  final int? idComment;
  final String status;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.idNotif,
    required this.userId,
    required this.idPost,
    this.idComment,
    required this.status,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      idNotif: json['id_notif'],
      userId: json['user_id'],
      idPost: json['id_post'] ?? -1,
      idComment: json['id_comment'],
      status: json['status'],
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
