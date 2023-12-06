import 'package:chat_app/view_models/chat_screen_view_model.dart';
import 'package:chat_app/views/widgets/chat_container_widget.dart';
import 'package:chat_app/views/widgets/message_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatScreenViewModel chatScreenViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Screen Group",
        style: TextStyle(
          color: Colors.black
        ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              }, 
              icon: const Icon(Icons.logout,color: Colors.black,))
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: chatScreenViewModel.formKey,
        child: Column(
          children : [
            Expanded(child: ChatContainer(chatScreenViewModel: chatScreenViewModel,)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: MessagesTextField(chatScreenViewModel: chatScreenViewModel),
            )
          ]
        ),
      ),
    );
  }
}
