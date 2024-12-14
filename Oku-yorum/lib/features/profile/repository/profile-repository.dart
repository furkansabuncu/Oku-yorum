import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojem/models/user_model.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository(
    auth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance));


class ProfileRepository{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  ProfileRepository({
    required this.firebaseFirestore,
    required this.auth
  });

  Future<UserModel> getUser() async {
    String? uid = auth.currentUser?.uid;
    if (uid == null) {
      // Firebase kullanıcısının oturum açtığından emin olun
      throw Exception("Kullanıcı oturumu açık değil.");
    }

    DocumentSnapshot userSnapshot = await firebaseFirestore
        .collection("users")
        .doc(uid)
        .get();

    if (!userSnapshot.exists) {
      // Kullanıcı dokümanı bulunamadı
      throw Exception("Kullanıcı bulunamadı.");
    }

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    return UserModel.fromMap(userData);
  }


}