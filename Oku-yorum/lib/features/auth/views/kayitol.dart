import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprojem/features/auth/controller/auth-controller.dart';
import 'package:flutterprojem/features/auth/views/girisbilgi.dart';
import 'package:flutterprojem/features/auth/views/girisyap.dart';


class Kayit extends StatefulWidget {
  const Kayit({super.key});

  @override
  State<Kayit> createState() => _KayitState();
}

class _KayitState extends State<Kayit> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final _formKey=GlobalKey<FormState>();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      alignment: Alignment.bottomCenter,
        children: [
          Container(

          height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const  BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/flutterlogoo.png'),
                fit: BoxFit.cover,

              )
            ),
          ),
          AspectRatio(aspectRatio: 1,child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(30),
                topRight: Radius.circular(20),
              )
            ),
            child:Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical:10 ),
                      alignment: Alignment.centerLeft,
                        child: Text("Kayit ol",style: TextStyle(color: Colors.black , fontSize: 24))
                
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "Email gerekli";
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.yellow,
                
                            )
                          ),
                
                        ),
                      ),
                    ),
                    Consumer(
                        builder: (context,ref,child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Şifre gerekli";
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                // İsteğe bağlı olarak boşluk ekleyebilirsiniz.
                                MaterialButton(
                                  minWidth: double.infinity,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: Colors.green,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ref
                                          .read(authControllerProvider)
                                          .signUpWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      )
                                          .then(
                                            (value) => Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignUpContinue(email: emailController.text),
                                          ),
                                              (route) => false,
                                        ),
                                      );
                                    }
                                  },

                                  child: Text(
                                    "Kayit ol",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                
                        },
                    ),
                
                    Align
                      (
                      alignment: Alignment.centerLeft,
                        child: Container(

                        )
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Giris(),
                          ),
                        ),
                        child: Text(
                          style:TextStyle(color: Colors.grey),
                          "Hesabın var mı giriş yap!"
                
                        ),
                
                
                      ),
                
                
                
                    )
                  ],
                ),
              ),
            ) ,
          ),

          ),
        ],
      ),
    );
  }
}

