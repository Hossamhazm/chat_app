import 'package:chat_app/models/user_model.dart';

abstract class ChatReposotry{
  Future <void> addUserDate(UserModel userModel);
  Future <void> sendMessage(String message);
}