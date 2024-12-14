import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojem/common/sizes.dart';
import 'package:flutterprojem/features/more/view/edit-profile.dart';
import 'package:flutterprojem/features/profile/controller/profile-controller.dart';
import 'package:flutterprojem/models/user_model.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: scaffoldPadding,
          child: FutureBuilder<UserModel>(
            future: ref.read(profileControllerProvider).getUser(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                final userModel=snapshot.data!;
                return Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(userModel.profilePhoto!),
                          backgroundColor: Colors.grey,

                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            userModel.name+" "+ userModel.surname,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          "@"+userModel.username,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MaterialButton(
                        elevation: 0,
                        minWidth: 200,
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        child: Text("Profili düzenle",style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold,color: Colors.white),),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(currentUser: userModel),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              else if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }else{
                return const Center(child: Text("Yanlış bir şeyler var"));
              }
            }
          ),
        ),
      ),

    );
  }
}

