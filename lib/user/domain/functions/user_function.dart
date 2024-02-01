import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/user_model.dart';
import 'package:share/user/presentation/widgets/commen_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserFunction {
  // add user in to firestore

  addUserDeatails(UserModel userModel, String compire) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
    await instant.where(compire, isEqualTo: userModel.email).get();
    final result = await instant.add(userModel.fromMap());
    return result.id;
  }

  // checking and authenticate user deatailes and send user credential

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var a= await FirebaseAuth.instance.signInWithCredential(credential);
      return a;
    } catch (e) {
      log('$e');
    }
  }

  // user pick image and send the path of image

  userPickImage() async {
    try {
      var a = await ImagePicker().pickImage(source: ImageSource.gallery);
      return a;
    } catch (e) {
      log('$e');
    }
  }

  // checkig user deatailes already logind or not , if login sent the id otherwise send false

  checkUserIsAlredyTheirOrNot(String email, String compare) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
    final val = await instant.where(compare, isEqualTo: email).get();
    if (val.docs.isNotEmpty) {
      return val.docs.first.id;
    } else {
      return false;
    }
  }

  // user login by email and password and send the id of user

  userLoginPasswordAndEmailChecking(String email, String password) async {
    try {
      final instant = FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
      final val = await instant
          .where(FirebaseFirestoreConst.firebaseFireStoreEmail,
              isEqualTo: email)
          .get();
      if (val.docs.isNotEmpty) {
        if (val.docs.first[FirebaseFirestoreConst.firebaseFireStorePassword] ==
            password) {
          return val.docs.first.id;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      CommonWidget().toastWidget('$e');
    }
  }

  // fetch all data of a single user by id

  fecchUserDataById(String userId) async {
    final val = await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection)
        .doc(userId)
        .get();
    var a = UserModel(
        userId: userId,
        email: val['email'],
        name: val['name'],
        password: val['password'],
        phone: val['phone'],
        imagePath: val['image']);
    return a;
  }

  // store image in to image path in firebase and send back the download url as image url

  uploadImageToFirebase(XFile xfile) async {
    final ref = FirebaseStorage.instance.ref('image').child(xfile.name);
    await ref.putFile(File(xfile.path));
    final imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }
}
