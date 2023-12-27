class Post {
  final int id;
  final bool byUser;
  final bool byUstadz;
  final String username;
  final int idUserUstadz;
  final String judul;
  final String konten;
  final String up;
  final String down;
  final bool? isLiked;
  final String commentCount;
  final String createdAt;
  final String updatedAt;

  Post({
    required this.id,
    required this.byUser,
    required this.byUstadz,
    required this.username,
    required this.idUserUstadz,
    required this.judul,
    required this.konten,
    required this.up,
    required this.down,
    required this.isLiked,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id_post'],
        byUser: json['byUser'],
        username: json['username'],
        idUserUstadz: json['id_user_ustadz'],
        judul: json['judul'],
        konten: json['konten'],
        up: json['up'],
        down: json['down'],
        isLiked: json['isLiked'],
        commentCount: json['commentCount'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        byUstadz: json['byUstadz']);
  }
}
