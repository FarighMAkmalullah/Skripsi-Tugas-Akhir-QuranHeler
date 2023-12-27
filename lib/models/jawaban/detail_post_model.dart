class Post {
  final int idPost;
  final String username;
  final bool byUser;
  final int idUserUstadz;
  final String judul;
  final String konten;
  final String up;
  final String down;
  final bool? isLiked;
  final String commentCount;
  final String createdAt;
  final String updatedAt;
  final List<Comment> comments;

  Post({
    required this.idPost,
    required this.username,
    required this.byUser,
    required this.idUserUstadz,
    required this.judul,
    required this.konten,
    required this.up,
    required this.down,
    required this.isLiked,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<Comment> commentsList = [];
    if (json['comment'] != null) {
      for (var comment in json['comment']) {
        commentsList.add(Comment.fromJson(comment));
      }
    }

    return Post(
      idPost: json['id_post'],
      username: json['username'],
      byUser: json['byUser'],
      idUserUstadz: json['id_user_ustadz'],
      judul: json['judul'],
      konten: json['konten'],
      up: json['up'],
      down: json['down'],
      isLiked: json['isLiked'],
      commentCount: json['commentCount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      comments: commentsList,
    );
  }
}

class Comment {
  final String name;
  final String role;
  final int idComment;
  final int userId;
  final int idPost;
  final int? idToComment;
  final String comment;
  final String createdAt;
  final String updatedAt;

  Comment({
    required this.name,
    required this.role,
    required this.idComment,
    required this.userId,
    required this.idPost,
    required this.idToComment,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      name: json['name'],
      role: json['role'],
      idComment: json['id_comment'],
      userId: json['user_id'],
      idPost: json['id_post'],
      idToComment: json['id_tocomment'],
      comment: json['comment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
