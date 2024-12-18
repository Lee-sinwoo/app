import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/firebase/firestore.dart';
import 'package:my_app/firebase/storage.dart';
import 'package:my_app/util/exeption.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> Signup({
    required String email,
    required String password,
    required String passwordConfirm,
    required String username,
    required String bio,
    required File profile,
  }) async {
    String URL;
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        if (password == passwordConfirm) {
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
          //upload profile image on storage

          if (profile != File('')) {
            URL =
                await StorageMethod().uploadImageToStorage('Profile', profile);
          } else {
            URL = '';
          }

          //get information with firestore

          await Firebase_Firestore().CreateUser(
            email: email,
            username: username,
            bio: bio,
            profile: URL == '' ? '' : URL,
          ); //비었을때 넣을 기본이미지인데 firebase아직 해결이 안 되어서 미완.
        } else {
          throw exeptions('password and confirm password should be same');
        }
      } else {
        throw exeptions('enter all the fields');
      }
    } on FirebaseException catch (e) {
      throw exeptions(e.message.toString());
    }
  }
}
