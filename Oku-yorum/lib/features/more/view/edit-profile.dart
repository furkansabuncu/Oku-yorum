import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojem/common/repository/common-firebase-storage.dart';
import 'package:flutterprojem/features/more/controller/more-controller.dart';
import 'package:flutterprojem/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.currentUser});
  final UserModel currentUser;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  XFile? _image;

  void selectImage() async {
    _image = await pickImageFromGallery();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentUser.name;
    _surnameController.text = widget.currentUser.surname;
    _emailController.text = widget.currentUser.email;
    _usernameController.text = "@${widget.currentUser.username}";
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: () => selectImage(),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 70,
                    backgroundImage: _image != null
                        ? FileImage(File(_image!.path)) as ImageProvider
                        : CachedNetworkImageProvider(
                      widget.currentUser.profilePhoto!,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                        controller: _nameController,
                        title: 'Name',
                        value: widget.currentUser.name,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InputField(
                      controller: _surnameController,
                      title: 'Surname',
                      value: widget.currentUser.surname,
                    ),
                  ),
                ],
              ),
             
              InputField(
                controller: _usernameController,
                title: 'Username',
                value: widget.currentUser.username,
              ),
              InputField(
                controller: _emailController,
                title: 'E-Mail',
                value: widget.currentUser.email,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: MaterialButton(
                      onPressed: () async {
                        widget.currentUser.name = _nameController.text;
                        widget.currentUser.surname = _surnameController.text;
                        widget.currentUser.email = _emailController.text;
                        widget.currentUser.username = _usernameController.text;
                        

                        if (_image != null) {
                          widget.currentUser.profilePhoto = await ref
                              .read(commonFSRepositoryProvider)
                              .storeFileToFirebase(
                            "profilePhotos/${widget.currentUser.uid}",
                            File(_image!.path),
                          );
                        } else {
                          widget.currentUser.profilePhoto =
                              widget.currentUser.profilePhoto;
                        }
                        UserModel userModel = widget.currentUser;
                        await ref
                            .read(moreControllerProvider)
                            .updateProfile(userModel)
                            .whenComplete(
                              () => Navigator.pop(context),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      color: Colors.grey,
                      minWidth: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          "Kaydet",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required TextEditingController controller,
    required this.title,
    required this.value,
  }) : _controller = controller;
  final String title;
  final String? value;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _controller,
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          fillColor: Colors.grey,
          filled: true,
          hintText: title,
          hintStyle: const TextStyle(
            color: Colors.blue,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}