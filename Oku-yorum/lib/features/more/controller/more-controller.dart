import 'package:flutterprojem/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojem/features/more/repository/more-repository.dart';
import 'package:flutterprojem/models/article-model.dart';
import 'package:flutterprojem/models/code-model.dart';
import 'package:flutterprojem/models/user_model.dart';


final moreControllerProvider = Provider((ref) {
  final moreRepository = ref.watch(moreRepositoryProvider);
  return MoreController(moreRepository: moreRepository, ref: ref);
});

class MoreController {
  final MoreRepository moreRepository;
  final ProviderRef ref;

  MoreController({required this.moreRepository, required this.ref});

  Future<void> signOut() async {
    await moreRepository.signOut();
  }

  Future<void> writeArticle(ArticleModel model) async {
    await moreRepository.writeArticle(model);
  }

  Stream<List<ArticleModel>> getArticles() {
    return moreRepository.getArticles();
  }



  Future<UserModel> getUser() async {
    return await moreRepository.getUser();
  }

  Future<void> updateProfile(UserModel model) async {
    await moreRepository.updateProfile(model);
    ref.refresh(moreControllerProvider).getUser();
  }


}