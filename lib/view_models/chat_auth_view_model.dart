import 'package:chat_app/repositories/auth_firebase/auth_local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
class ChatAuthViewModel extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isSignUp = false;
  bool isUploading = false;
  String errorMessage = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? selectedImage;


  ChatAuthViewModel(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    isSignUp = false;
    errorMessage = '';
    formKey = GlobalKey<FormState>();
    submitForm();
  }
  void toggleAuthMode() {
      isSignUp = !isSignUp;
      errorMessage = '';
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      notifyListeners();
  }
  Future<void> submitForm() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String name = nameController.text;
    if (formKey.currentState != null && formKey.currentState!.validate() || (isSignUp && selectedImage == null)) {
      try {
        isUploading = true;
        notifyListeners();

        if (isSignUp) {
          await ChatAuth().createUserWithEmailAndPassword(email, password, selectedImage!,name);
        } else {
          await ChatAuth().signInWithEmailAndPassword(email, password!);
        }
      } on FirebaseAuthException catch (e) {
        errorMessage = e.message!;
        print("Erorr@%#%%&%#%@#%^ $errorMessage");
        notifyListeners();
      } catch (e) {
        errorMessage = 'An error occurred. Please try again later.';
        notifyListeners();
      }
      isUploading = false;
      notifyListeners();
    }
  }
  Future imageFromGallery() async {
    try {
      XFile? image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
      );
      selectedImage = image;
      notifyListeners();
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
  Future imageFromCamera() async {
    try {
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      selectedImage = image;
      notifyListeners();
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
}