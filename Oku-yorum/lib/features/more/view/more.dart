import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterprojem/common/paths.dart';
import 'package:flutterprojem/features/auth/views/girisyap.dart';
import 'package:flutterprojem/features/more/controller/more-controller.dart';
import 'package:flutterprojem/features/more/view/edit-profile.dart';
import 'package:flutterprojem/features/more/view/write-article.dart';
import 'package:flutterprojem/features/more/view/your-articles.dart';
import 'package:flutterprojem/models/user_model.dart';
import 'package:flutterprojem/features/widgets/subtitle-widget.dart';


class More extends ConsumerWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
          future: ref.read(moreControllerProvider).getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userModel = snapshot.data!;
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Aktivite Sayfası",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider(
                                userModel.profilePhoto!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider( // This is the added divider
                        color: Colors.grey,
                        thickness: 1,
                        height: 20,
                      ),
                      const SubTitleWidget(
                        title: "İşlem seçiniz",
                      ),
                      MenuItem(
                        title: "Kitap tavsiyesi ekle!",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WriteArticle(currentUser: userModel),
                            ),
                          );
                        },
                        leadingAsset: addBookNewSvg,
                      ),
                      MenuItem(
                        title: "Kitap tavsiyelerim",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => YourArticles(),
                            ),
                          );
                        },
                        leadingAsset: myBookSvg,
                      ),

                      const SubTitleWidget(
                        title: "Profile",
                      ),
                      MenuItem(
                        title: "Profili düzenle",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(currentUser: userModel),
                            ),
                          );
                        },
                        leadingAsset: updateMyProfile,
                      ),
                      MenuItem(
                        title: "Çıkış yap",
                        onTap: () {
                          ref
                              .read(moreControllerProvider)
                              .signOut()
                              .whenComplete(() => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Giris(),
                              ),
                                  (route) => false));
                        },
                        leadingAsset: exitSvg,
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          }),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    this.onTap,
    required this.title,
    required this.leadingAsset,
  }) : super(key: key);
  final Function()? onTap;
  final String title;
  final String leadingAsset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Card(
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 10,
          child: ListTile(
            leading: SvgPicture.asset(
              leadingAsset,
            ),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
