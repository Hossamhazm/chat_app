import 'package:chat_app/repositories/firestore_firebase/firestore_reposotry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatDatabase extends ChatReposotry {
  @override
  Future<void> addUserDate(userModel) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return await users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'id': userModel.id,
      'image_url': userModel.imageUrl,
      'email': userModel.email,
      'user_name': userModel.name,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Future<void> sendMessage(message) async {
    CollectionReference sendMessage = FirebaseFirestore.instance.collection('send_message');

    try {
      final getMessageDataFromFirestore = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (getMessageDataFromFirestore.exists) {
        String? userName = getMessageDataFromFirestore.data()?['user_name'];
        String? imageUrl = getMessageDataFromFirestore.data()?['image_url'];

        await sendMessage.add({
          'message': message,
          'send_time': Timestamp.now(),
          'user_id': FirebaseAuth.instance.currentUser!.uid,
          'user_name': userName,
          'user_image': imageUrl,
        });

        print("Message Sent : $userName");
      } else {
        print("Failed to retrieve user data from Firestore");
      }
    } catch (error) {
      print("Failed to send Message: $error");
    }
  }
}