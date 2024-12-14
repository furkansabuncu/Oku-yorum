
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojem/features/browse/repository/browse-repository.dart';
import 'package:flutterprojem/models/article-model.dart';
import 'package:flutterprojem/models/code-model.dart';



final browseControllerProvider = Provider((ref) => BrowseController(
  browseRepository: ref.watch(browseRepositoryProvider),
));

class BrowseController {
  final BrowseRepository browseRepository;
  BrowseController({required this.browseRepository});

  Stream<List<ArticleModel>> getArticles() {
    return browseRepository.getArticles();
  }

  Stream<List<CodeModel>> getCodes() {
    return browseRepository.getCodes();
  }
}