import 'dart:io';
import 'package:flutter/material.dart';
import '../../view_models/chat_auth_view_model.dart';

class UserImagePicker extends StatelessWidget {
  ChatAuthViewModel chatAuthViewModel;
  UserImagePicker({Key? key,required this.chatAuthViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CircleAvatar(
           backgroundImage: chatAuthViewModel.selectedImage == null
               ? null
               : FileImage(File(chatAuthViewModel.selectedImage!.path)),
          radius: 55,
        ),
        const SizedBox(height: 15,),
        ElevatedButton(
            onPressed: chatAuthViewModel.imageFromGallery,
            child:const Text("take image from gallery") ),
        ElevatedButton(
            onPressed: chatAuthViewModel.imageFromCamera,
            child:const Text("take image from camera") )
      ],
    );
  }
}
