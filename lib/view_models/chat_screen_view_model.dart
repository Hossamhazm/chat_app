import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../repositories/firestore_firebase/firestore_local.dart';

class ChatScreenViewModel extends ChangeNotifier{
  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final stream = FirebaseFirestore.instance.collection('send_message').orderBy('send_time',descending: true).snapshots();

  ChatScreenViewModel(){
    messageController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  toggleChatScreen(){
    messageController.clear();
    notifyListeners();
  }

  void sendMessage() async{
    if(formKey.currentState != null && formKey.currentState!.validate()){
      if(messageController.text.isEmpty){
        return;
      }
      await ChatDatabase().sendMessage(messageController.text);
    }
  }
}