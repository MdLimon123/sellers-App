import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  XFile? imageFile;
  ImagePicker pickedImage = ImagePicker();

  pickImageFormGallery()async{
    imageFile = await pickedImage.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
         const SizedBox(height: 11,),

          InkWell(
            onTap: (){
              pickImageFormGallery();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageFile == null ? null: FileImage(File(imageFile!.path)),
              child: imageFile == null?
              Icon(Icons.add_photo_alternate,
              size: MediaQuery.of(context).size.width * 0.20,
              color: Colors.grey,)
              : null,
            ),
          )

        ],
      ),
    );
  }
}
