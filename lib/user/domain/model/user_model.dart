import 'dart:developer';

import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';

class UserModel {
   String name;
  final String password;
   String phone;
   String imagePath;
  final String email;
  final String? userId;
  final List<dynamic> favirote;

  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.password,
      required this.phone,
      required this.imagePath,  
      required this.favirote
      });

  Map<String, dynamic> toMap() {
    return {
      "userId":userId,
      "email": email,
      "name": name,
      "password": password,
      "phone": phone,
      "image": imagePath,
      "favorite" : favirote 
    };
  }

  static UserModel fromMap(Map<String, dynamic> map, String userId) {
    log('${map[FirebaseFirestoreConst.firebaseFireStoreImage]}');
    UserModel a= UserModel(
        userId: userId,
        favirote: map[FirebaseFirestoreConst.firebaseFireStoreFavorite] ?? [],
        email: map[FirebaseFirestoreConst.firebaseFireStoreEmail],
        name: map[FirebaseFirestoreConst.firebaseFireStoreName],
        password: map[FirebaseFirestoreConst.firebaseFireStorePassword],
        phone: map[FirebaseFirestoreConst.firebaseFireStorePhone],
        imagePath: map[FirebaseFirestoreConst.firebaseFireStoreImage]);
         log('user deatails kitty');
    return a;
  }
}
