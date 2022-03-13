import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:path/path.dart';

class FirebasePost {
   File? image;
   String name;
   String price;
   String gender;
   String size;

   FirebasePost({
     required this.image,
     required this.name,
     required this.price,
     required this.gender,
     required this. size
   });


  storage.FirebaseStorage bucket=storage.FirebaseStorage.instance;

  Future uploadPhoto() async {

    if (image == null) {return ;}

    final fileName = basename(image!.path.split("/").last);
    final destination = 'files/$fileName';

    try {
      final ref = storage.FirebaseStorage.instance
          .ref(destination)
          .child('photos/');

      UploadTask uploadTask=ref.putFile(image!);

      TaskSnapshot snap=await uploadTask;
      String downloadUrl=await snap.ref.getDownloadURL();

      FirebaseFirestore.instance.collection("posts").add(
          {
            "name":name,
            "price":price,
            "sex":gender,
            "size":size,
            "imageUrl":downloadUrl,
          }
      ).then((value) => print("cloth added"))
          .catchError((e)=> print("failed $e"));

    } catch (e) {
      print('error occured $e');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
