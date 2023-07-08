import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// TODO: 파이어베이스 auth인스턴스를 사용하여 사용자가 이메일과 비밀번호 로그인하게 할 수 있다
// auth 인스턴스에서 UserCredential 리턴

Future<void> loginWithEmailAndPassword(
    FirebaseAuth auth, String email, String password) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    print('user login with ${user!.email}');
  } catch (e) {
    print('Login Failed :$e');
  }
}

//TODO 현재 사용자를 로그아웃 시킴
Future<void> logOut(BuildContext context, FirebaseAuth auth) async {
  try {
    await auth.signOut();
  } catch (e) {}
}

//TODO 이메일과 비밀번호로 회원가입
Future<void> registerWithEmail(FirebaseAuth auth, String email, String password,
    String name, BuildContext context) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = userCredential.user;
    if (user == null) {
      print('Register Fail');
    } else {
      print('Register Success');
      Navigator.pushReplacementNamed(context, '/login');
    }
  } catch (e) {}
}
