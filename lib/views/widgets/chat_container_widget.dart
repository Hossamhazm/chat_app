import 'package:chat_app/message_bubble.dart';
import 'package:chat_app/view_models/chat_screen_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatContainer extends StatelessWidget {
  ChatScreenViewModel chatScreenViewModel;
  ChatContainer({Key? key,required this.chatScreenViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: chatScreenViewModel.stream,
        builder: (context , snapshot){
          if(snapshot.hasError){
            return const Text("SomeThing Error");
          }
          if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return const Text("No Data...");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.data!.docs;
          return ListView.builder(
            reverse: true,
              itemCount: docs.length,
              itemBuilder: (_ , index){
              final chatMessage = docs[index].data();
              final nextMessage =index+1< docs.length? docs[index+1].data() : null;
              final currentMessageUserId = chatMessage['user_id'];
              final nextMessageUserId =nextMessage!=null? nextMessage['user_id']: null;
              final bool nextUserIsSame = currentMessageUserId == nextMessageUserId;
              final userImage = docs[index].data()['user_image'];
              final userName = docs[index].data()['user_name'];
              if(nextUserIsSame){
                return MessageBubble.next(
                    message: chatMessage['message'],
                    isMe: authUser.uid == currentMessageUserId);
              }else{
                return MessageBubble.first(
                    userImage: userImage,
                    username: userName,
                    message: chatMessage['message'],
                    isMe: authUser.uid == currentMessageUserId);
              }
              });
        });
  }
}
