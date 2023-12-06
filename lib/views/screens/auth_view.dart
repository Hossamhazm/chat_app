import 'package:chat_app/views/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/chat_auth_view_model.dart';
class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatAuthViewModel chatAuthViewModel = Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: chatAuthViewModel.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                chatAuthViewModel.isSignUp?  UserImagePicker(chatAuthViewModel: chatAuthViewModel) :const Text("WelcomeBack!"),
                chatAuthViewModel.isSignUp==true? TextFormField(
                  controller: chatAuthViewModel.nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid name';
                    }
                    return null;
                  },
                ): Text("WELCOME BACK ${chatAuthViewModel.nameController.text}!",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.green
                  ),
                ),
                TextFormField(
                  controller: chatAuthViewModel.emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: chatAuthViewModel.passwordController,
                  decoration: const InputDecoration(labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                if (chatAuthViewModel.errorMessage.isNotEmpty)
                  Text(
                    chatAuthViewModel.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 16.0),
                if(chatAuthViewModel.isUploading == true) const CircularProgressIndicator(),
                if(chatAuthViewModel.isUploading == false) ElevatedButton(
                  onPressed: chatAuthViewModel.submitForm,
                  child: Text(chatAuthViewModel.isSignUp ? 'Sign Up' : 'Log In'),
                ),
                if(chatAuthViewModel.isUploading == false) TextButton(
                  onPressed: chatAuthViewModel.toggleAuthMode,
                  child: Text(
                    chatAuthViewModel.isSignUp ? 'Already have an account? Log In' : 'Create a new account',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
