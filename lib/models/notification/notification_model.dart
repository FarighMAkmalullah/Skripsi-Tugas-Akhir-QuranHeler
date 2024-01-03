class NotificationModel {
  final int idNotif;
  final int userId;
  final int idPost;
  final int? idComment;
  final String status;
  final bool isRead;
  final String createdAt;

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
      idPost: json['id_post'],
      idComment: json['id_comment'],
      status: json['status'],
      isRead: json['is_read'],
      createdAt: json['created_at'],
    );
  }
}
