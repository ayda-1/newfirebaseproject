import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newfirebaseproject/firebase_firestore_kullanimi.dart';
import 'package:newfirebaseproject/firebase_options.dart';

void main() async {
  //bunların kesinlikle olması gerekio
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseFirestoreKullanimi(),
    );
  }
}

class MyProject extends StatefulWidget {
  const MyProject({super.key});

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  final String email = "softitobos@gmail.com";
  final String password = "pass123456";
  late FirebaseAuth auth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      //callback
      if (user == null) {
        debugPrint("Kullanıcı oturumu kapattı");
      } else {
        debugPrint(
          "Kullanıcı oturum açtı ${user.email}, email durumu: ${user.emailVerified}",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Auth"),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  createUserEmailAndPassword();
                },
                child: Text(
                  "Kayıt Ol",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),

            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  loginUserEmailAndPassword();
                },
                child: Text(
                  "Giriş Yap",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  deleteUser();
                },
                child: Text(
                  "Sil",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  signOutUser();
                },
                child: Text(
                  "Çıkış Yap",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  changePass();
                },
                child: Text(
                  "Şifre Değiştir",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  changeMail();
                },
                child: Text(
                  "Mail Değiştir",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createUserEmailAndPassword() async {
    try {
      var _userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var _myUser = _userCredential.user!;
      if (!_myUser.emailVerified) {
        _myUser.sendEmailVerification();
      }

      debugPrint(_userCredential.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void loginUserEmailAndPassword() async {
    try {
      var _userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(_userCredential.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void signOutUser() async {
    await auth.signOut();
  }

  void deleteUser() async {
    if (auth.currentUser != null) {
      await auth.currentUser!.delete();
    } else {
      debugPrint("Önce oturum aç");
    }
  }

  void changePass() async {
    try {
      await auth.currentUser!.updatePassword("yeniSifre");
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        debugPrint("tekrar oturum açmalı");
        var credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        await auth.currentUser!.updatePassword("yeniSifre");
        await auth.signOut();
        debugPrint("Şifre güncellendi");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeMail() async {
    try {
      await auth.currentUser!.verifyBeforeUpdateEmail("58ayda58@gmail.com");
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        var credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        auth.currentUser!.reauthenticateWithCredential(credential);
        await auth.currentUser!.verifyBeforeUpdateEmail("58ayda58@gmail.com");
        await auth.signOut();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
