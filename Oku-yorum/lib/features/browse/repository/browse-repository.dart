// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojem/features/browse/views/article.dart';
import 'package:flutterprojem/models/article-model.dart';
import 'package:flutterprojem/models/code-model.dart';



final browseRepositoryProvider = Provider((ref) => BrowseRepository(
  firebaseFirestore: FirebaseFirestore.instance,
  auth: FirebaseAuth.instance,
));

class BrowseRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  BrowseRepository({
    required this.firebaseFirestore,
    required this.auth,
  });

  Stream<List<ArticleModel>> getArticles() {
    return firebaseFirestore
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      List<ArticleModel> list = [];
      for (var model in snapshot.docs) {
        list.add(
          ArticleModel.fromMap(
            model.data(),
          ),
        );
      }
      return list;
    });
  }

  Stream<List<CodeModel>> getCodes() {
    return firebaseFirestore
        .collection('codes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      List<CodeModel> list = [];
      for (var model in snapshot.docs) {
        list.add(
          CodeModel.fromMap(
            model.data(),
          ),
        );
      }
      return list;
    });
  }
}