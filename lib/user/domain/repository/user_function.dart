import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/user/domain/const/bd_cosnt.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/user_model.dart';
import 'package:share/user/presentation/widgets/commen_widget.dart';

class UserFunction {
  addUserDeatails(UserModel userModel, String compire) async {
    final instant = FirebaseFirestore.instance.collection(DbConst().userDb);
    await instant.where(compire, isEqualTo: userModel.email).get();
    final result = await instant.add(userModel.fromMap());
    return result.id;
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('$e');
    }
  }

  userPickImage() async {
    try {
      var a = await ImagePicker().pickImage(source: ImageSource.gallery);
      return a!.path;
    } catch (e) {
      log('$e');
    }
  }

  checkUserIsAlredyTheirOrNot(String email, String compare) async {
    print('##########################');
    final instant = FirebaseFirestore.instance.collection(DbConst().userDb);
    print('##########################22222222222222');
    final val = await instant.where(compare, isEqualTo: email).get();
    print('##########################333333333333');
    if (val.docs.isNotEmpty) {
      return val.docs.first.id;
    } else {
      return false;
    }
  }

  userLoginPasswordAndEmailChecking(String email, String password) async {
    try {
      final instant = FirebaseFirestore.instance.collection(DbConst().userDb);
      final val = await instant
          .where(FirebaseFirestoreConst().firebaseFireStoreEmail,
              isEqualTo: email)
          .get();
      if (val.docs.isNotEmpty) {
        if (val.docs
                .first[FirebaseFirestoreConst().firebaseFireStorePassword] ==
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
}
