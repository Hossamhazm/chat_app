import 'dart:io';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/repositories/firestore_firebase/firestore_local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'auth_repository.dart';

class ChatAuth extends AuthReposotry{
  @override
  Future<void> createUserWithEmailAndPassword(email , password, selectedImage,name) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("user credential sign in : ${credential.user}");
      print("******************************************************************************");
      Reference storageRef = FirebaseStorage.instance.ref().child('user_images').child("${credential.user!.uid}.jpg");
      TaskSnapshot uploadTask = await storageRef.putFile(File(selectedImage.path));
      String imageUrl = await uploadTask.ref.getDownloadURL();
      UserModel userModel = UserModel(id: credential.user!.uid, imageUrl: imageUrl, email: email, name: name);
      ChatDatabase().addUserDate(userModel);

      print("Image URL: $imageUrl");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(email, password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User credential sign up: ${credential.user}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }


}
