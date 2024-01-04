// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_app/components/CustomButton.dart';

import '../components/CustomTextForm.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

bool isLogin = false;

bool IsLogin() => isLogin;
TextEditingController name = TextEditingController();

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formstate = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future signIn() async {
    showDialog(
        context: context,
        builder: ((context) => const Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ))));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed("homePage");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Hata',
          desc: 'Kullanıcı Bulunmadı!',
          autoHide: const Duration(seconds: 3),
        ).show();
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          desc: 'Şifre Hatalı!',
          title: 'Hata',
          autoHide: const Duration(seconds: 3),
        ).show();
      } else {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          desc: 'Çok fazla deneme yaptınız,Lütfen daha sonra tekrar deneyiniz',
          title: 'Hata',
          autoHide: const Duration(seconds: 3),
        ).show();
      }
    }
  }

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
            child: CircularProgressIndicator(color: Colors.green)));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      FirebaseAuth.instance.currentUser!.updateDisplayName(userName.text);
      Navigator.of(context).pop();
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        desc: 'Hesabi olusturuldu! Lütfen giriş yapınız.',
        title: 'Tebrikler',
        autoHide: const Duration(seconds: 3),
      ).show();
      Navigator.of(context).pushReplacementNamed("authScreen");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.scale,
          desc: 'Lütfen daha karmaşık bir şifre giriniz',
          title: 'Hata',
          autoHide: const Duration(seconds: 3),
        ).show();
      } else if (e.code == 'email-already-in-use') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.scale,
          desc: 'Bu E-postaya ait hesap zaten mevcut.',
          title: 'Hata',
          autoHide: const Duration(seconds: 3),
        ).show();
      }
    }
  }

  Future googleSignIn() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    print(FirebaseAuth.instance.authStateChanges());
    Navigator.of(context).pushReplacementNamed("homePage");
  }

  bool isLogin = true;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 2 / 10),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          //color: Colors.red,
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Image.asset(
                              "assets/images/app-icon.png",
                              height: 150,
                            ),
                          ),
                        ),
                        if (!isLogin)
                          CustomTextForm(
                            controller: name,
                            textInputType: TextInputType.name,
                            labelText: 'Ad',
                            icon: Icons.person,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Lütfen Adınızı giriniz';
                              }
                              return null;
                            },
                          ),
                        if (!isLogin)
                          CustomTextForm(
                            controller: userName,
                            labelText: 'Kullanıcı Adı',
                            icon: Icons.person_pin,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Lütfen kullanıcı adınızı giriniz';
                              }
                              return null;
                            },
                          ),
                        CustomTextForm(
                          controller: email,
                          labelText: 'E-posta',
                          textInputType: TextInputType.emailAddress,
                          icon: Icons.alternate_email,
                          validator: (val) {
                            if (!EmailValidator.validate(val!)) {
                              return 'Lütfen Geçerli bir E-posta giriniz';
                            }
                            return null;
                          },
                        ),
                        CustomTextForm(
                          controller: password,
                          textInputType: TextInputType.visiblePassword,
                          obsecureText: true,
                          labelText: 'Şifre',
                          icon: Icons.password,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Lütfen şifre giriniz';
                            }
                            if (val.trim().length < 8) {
                              return 'Lütfen en az 8 karakter giriniz';
                            }
                            return null;
                          },
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (isLogin)
                                Container(
                                  height: 35,
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: const Text("Şifremi unuttum")),
                                ),
                              SizedBox(
                                width: 130,
                                child: CustomButton(
                                  onPressed: () async {
                                    if (!isLogin &&
                                        _formstate.currentState!.validate()) {
                                      signUp();
                                    } else if (isLogin &&
                                        _formstate.currentState!.validate())
                                      signIn();
                                  },
                                  buttonText:
                                      isLogin ? 'Giriş Yap' : "Hesap Oluştur",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                                _formstate.currentState!.reset();
                              });
                            },
                            child: isLogin
                                ? const Text("Hesabım yok")
                                : const Text("Hesabın var mı?"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(),
                            onPressed: () => googleSignIn(),
                            child: Text("Google ile Giriş Yap"),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      );
}
