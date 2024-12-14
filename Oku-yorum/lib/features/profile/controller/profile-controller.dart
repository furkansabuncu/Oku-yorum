import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojem/features/profile/repository/profile-repository.dart';
import 'package:flutterprojem/models/user_model.dart';

final profileControllerProvider = Provider((ref) => ProfileController(
profileRepository: ref.read(profileRepositoryProvider),
));


class ProfileController{
  final ProfileRepository profileRepository;

  ProfileController({
    required this.profileRepository
  });

  Future<UserModel> getUser() async{
    return await profileRepository.getUser();
  }
}