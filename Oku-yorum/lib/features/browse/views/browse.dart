import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterprojem/common/paths.dart';
import 'package:flutterprojem/features/browse/controller/browse-controller.dart';
import 'package:flutterprojem/features/browse/views/article.dart';
import 'package:flutterprojem/features/widgets/appbar-with-title.dart';
import 'package:flutterprojem/features/widgets/content-listview.dart';
import 'package:flutterprojem/features/widgets/subtitle-widget.dart';
import 'package:flutterprojem/models/article-model.dart';

class Browse extends ConsumerWidget {
  const Browse({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<List<ArticleModel>>(
          stream: ref.watch(browseControllerProvider).getArticles(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final articles = snapshot.data!;

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppBarWithTitle(title: "Keşfet"),
                      const Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 1,
                      ),
                      Row(
                        children: const [
                          SubTitleWidget(title: "Son eklenen yorumlar"),
                          SizedBox(width: 8), // Boşluk eklemek için
                          Icon(Icons.newspaper, color: Colors.black),
                        ],
                      ),
                      SizedBox(
                        height: 150, // Bu değeri ihtiyacınıza göre ayarlayabilirsiniz
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Article(article: article),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  width: 150, // Adjust the width as needed
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(article.coverImg!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          article.title,
                                          style: const TextStyle(
                                            fontSize: 14, // Adjust the font size as needed
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          article.author,
                                          style: const TextStyle(
                                            fontSize: 12, // Adjust the font size as needed
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 1,
                      ),
                      Row(
                        children: const [
                          SubTitleWidget(title: "Eklenen tüm kitap yorumları"),
                          SizedBox(width: 8), // Boşluk eklemek için
                          Icon(Icons.book, color: Colors.black),
                        ],
                      ),
                      Expanded(
                        flex: 5,
                        child: ListView.separated(
                          itemCount: articles.length,
                          separatorBuilder: (BuildContext context, int index) => const Divider(
                            color: Colors.grey,
                            height: 20,
                            thickness: 1,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final article = articles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Article(article: article),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(article.coverImg!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              article.title,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.clip,
                                            ),
                                            Text(
                                              article.author,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "", // Burada tarih veya diğer verileri gösterebilirsiniz
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: SvgPicture.asset(
                                          rightArrow,
                                            colorFilter: const ColorFilter.mode(
                                              Colors.black,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
