import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/global/global_instances.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:sellers_app/global/global_vars.dart';
import 'package:sellers_app/view/mainScreen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel {
  validateSignUpForm(
      XFile? imageFile,
      String password,
      String confirmPassword,
      String email,
      String name,
      String phone,
      String locationAddress,
      BuildContext context) async {
    if (imageFile == null) {
      commonViewModel.showSnackBar('Please select image file.', context);
      return;
    } else {
      if (password == confirmPassword) {
        if (name.isNotEmpty &&
            email.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            phone.isNotEmpty &&
            locationAddress.isNotEmpty) {

          commonViewModel.showSnackBar("Please wait..", context);
          // signup

          User? currentFirebaseUser =
              await createUserInFirebaseAuth(email, password, context);

          String downloadUrl = await uploadImageToStorage(imageFile);

          await saveUserDataToFirestore(currentFirebaseUser, downloadUrl, name,
              email, password, locationAddress, phone);

          Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
          
          commonViewModel.showSnackBar("Account Create Successfully", context);

        } else {
          commonViewModel.showSnackBar('password fill all fields.', context);
          return;
        }
      } else {
        commonViewModel.showSnackBar('password do not match.', context);
        return;
      }
    }
  }

  createUserInFirebaseAuth(
      String email, String password, BuildContext context) async {
    User? currentFirebaseUser;

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((valueAuth) {
      currentFirebaseUser = valueAuth.user;
    }).catchError((errorMsg) {
      commonViewModel.showSnackBar(errorMsg, context);
    });

    if (currentFirebaseUser == null) {
      return;
    }

    return currentFirebaseUser;
  }

  uploadImageToStorage(XFile? imageFile) async {
    String downloadUrl = "";

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
        .ref()
        .child('sellerImages')
        .child(fileName);

    fStorage.UploadTask uploadTask = storageRef.putFile(File(imageFile!.path));
    fStorage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => {});
    await taskSnapshot.ref.getDownloadURL().then((imageUrl) {
      downloadUrl = imageUrl;
    });

    return downloadUrl;
  }

  saveUserDataToFirestore(currentFirebaseUser, downloadUrl, name, email,
      password, locationAddress, phone) async{
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentFirebaseUser.uid)
        .set({
      "uid": currentFirebaseUser.uid,
      "email": email,
      "name": name,
      "phone": phone,
      "address": locationAddress,
      "status": "approved",
      "earning": 0.0,
      "latitude": position!.latitude,
      "longitude": position!.longitude
    });

    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentFirebaseUser.uid);
    await sharedPreferences!.setString("email", email);
    await sharedPreferences!.setString("name", name);
    await sharedPreferences!.setString("imageUrl", downloadUrl);


  }
}
