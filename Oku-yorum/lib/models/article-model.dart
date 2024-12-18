class ArticleModel {
  String uid;
  String title;
  String? coverImg;
  String content;
  String author;
  String autherUid;
  String authorImg;
  DateTime createdAt;

  ArticleModel({
    required this.uid,
    required this.title,
    this.coverImg,
    required this.content,
    required this.author,
    required this.autherUid,
    required this.authorImg,
    required this.createdAt,

  });

  ArticleModel copyWith({
    String? uid,
    String? title,
    String? coverImg,
    String? content,
    String? author,
    String? autherUid,
    String? authorImg,
    DateTime? createdAt,

  }) {
    return ArticleModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      coverImg: coverImg ?? this.coverImg,
      content: content ?? this.content,
      author: author ?? this.author,
      autherUid: autherUid ?? this.autherUid,
      authorImg: authorImg ?? this.authorImg,
      createdAt: createdAt ?? this.createdAt,

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'coverImg': coverImg,
      'content': content,
      'author': author,
      'autherUid': autherUid,
      'authorImg': authorImg,
      'createdAt': createdAt.millisecondsSinceEpoch,

    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      coverImg: map['coverImg'] != null ? map['coverImg'] as String : null,
      content: map['content'] as String,
      author: map['author'] as String,
      autherUid: map['autherUid'] as String,
      authorImg: map['authorImg'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),

    );
  }

  @override
  String toString() {
    return 'ArticleModel(uid: $uid, title: $title, coverImg: $coverImg, content: $content, author: $author, autherUid: $autherUid, authorImg: $authorImg, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ArticleModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.coverImg == coverImg &&
        other.content == content &&
        other.author == author &&
        other.autherUid == autherUid &&
        other.authorImg == authorImg &&
        other.createdAt == createdAt ;

  }

  @override
  int get hashCode {
    return uid.hashCode ^
    title.hashCode ^
    coverImg.hashCode ^
    content.hashCode ^
    author.hashCode ^
    autherUid.hashCode ^
    authorImg.hashCode ^
    createdAt.hashCode;

  }
}