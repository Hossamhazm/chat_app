import 'package:chat_app/view_models/chat_screen_view_model.dart';
import 'package:flutter/material.dart';

class MessagesTextField extends StatelessWidget {
  ChatScreenViewModel chatScreenViewModel ;
  MessagesTextField({Key? key, required this.chatScreenViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: chatScreenViewModel.messageController,
      decoration: InputDecoration(
        labelText: 'Send Message',
        suffixIcon : IconButton(
            onPressed: (){
              chatScreenViewModel.sendMessage();
              chatScreenViewModel.toggleChatScreen();
            },
            icon: const Icon(Icons.send)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your message';
        }
        return null;
      },
      autocorrect: true,
    );
  }
}
