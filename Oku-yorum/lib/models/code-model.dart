// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CodeModel {
  String uid;
  String title;
  String? coverImg;
  String author;
  String autherUid;


  CodeModel({
    required this.uid,
    required this.title,
    this.coverImg,
    required this.author,
    required this.autherUid,

  });

  CodeModel copyWith({
    String? uid,
    String? title,
    String? coverImg,
    String? author,
    String? autherUid,
  }) {
    return CodeModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      coverImg: coverImg ?? this.coverImg,

      author: author ?? this.author,
      autherUid: autherUid ?? this.autherUid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'coverImg': coverImg,

      'author': author,
      'autherUid': autherUid,

    };
  }

  factory CodeModel.fromMap(Map<String, dynamic> map) {
    return CodeModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      coverImg: map['coverImg'] != null ? map['coverImg'] as String : null,

      author: map['author'] as String,
      autherUid: map['autherUid'] as String,

    );
  }

  String toJson() => json.encode(toMap());

  factory CodeModel.fromJson(String source) =>
      CodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CodeModel(uid: $uid, title: $title, coverImg: $coverImg, author: $author, autherUid: $autherUid)';
  }

  @override
  bool operator ==(covariant CodeModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.coverImg == coverImg &&

        other.author == author &&
        other.autherUid == autherUid ;

  }

  @override
  int get hashCode {
    return uid.hashCode ^
    title.hashCode ^
    coverImg.hashCode ^
    author.hashCode ^
    autherUid.hashCode;

  }
}