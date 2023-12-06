import 'package:image_picker/image_picker.dart';

abstract class AuthReposotry{
  Future<void> createUserWithEmailAndPassword(String email , String password,XFile selectedImage,String name);
  Future<void> signInWithEmailAndPassword(String email , String password);
}

