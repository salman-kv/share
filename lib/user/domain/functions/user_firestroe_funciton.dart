// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/user/aplication/search_bloc/search_bloc.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/shared_prefrence.dart';
import 'package:share/user/domain/model/room_model.dart';
import 'package:share/user/domain/model/user_model.dart';
import 'package:share/user/presentation/alerts/toasts.dart';
import 'package:http/http.dart' as http;
import 'package:share/user/presentation/pages/userLogin/user_login_page.dart';

class UserFireStroreFunction {
  // add user in to firestore

  addUserDeatails(UserModel userModel, String compire) async {
    final instant = FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection);
    await instant.where(compire, isEqualTo: userModel.email).get();
    final result = await instant.add(userModel.toMap());
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
      var a = await FirebaseAuth.instance.signInWithCredential(credential);
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
      Toasts().toastWidget('$e');
    }
  }

  // fetch all data of a single user by id

  fecchUserDataById(String userId) async {
    final val = await FirebaseFirestore.instance
        .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection)
        .doc(userId)
        .get();
    var a = UserModel(
      favirote: val['favorite'],
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

  // find curent location of user

  getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      log('service enabled');
    } else {
      log('please enable location');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        locationPermission = await Geolocator.requestPermission();
        log('Location permission is denied');
      } else {
        log('Permission grand after request');
      }
    } else {
      log('permission granted');
    }
    if (locationPermission == LocationPermission.whileInUse ||
        locationPermission == LocationPermission.always) {
      // find the current location by geo locator
      var position = await Geolocator.getCurrentPosition();
      BlocProvider.of<SearchBloc>(context).position = LatLng(position.latitude, position.longitude);
      log('current postion');
      log('${BlocProvider.of<SearchBloc>(context).position}');
      return LatLng(position.latitude, position.longitude);
    }
  }

  // get placemaker or get the deatails about a latlng value

  getPlaceMakerDeatails(
      {required LatLng latLng, required BuildContext context}) async {
    // finding the address of a postion
    var address =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    BlocProvider.of<SearchBloc>(context).placemark = address[0];
    log('${address[0]}');
    return address[0];
  }


  // fins the distance between two latlng values

getDistanceBetweenTwoLatLnfg(
    {required LatLng latLng1, required LatLng latLng2}){
  double distance =  FlutterMapMath().distanceBetween(latLng1.latitude,
      latLng1.longitude, latLng2.latitude, latLng2.longitude, "meter");
  return distance;
}


// get data from firestore and store in to bloc

getRoomDataFromFireStoreAndStore({required BuildContext context})async{
// LatLng userLatLng=BlocProvider.of<SearchBloc>(context).position!;
// Placemark userPlaceMark=BlocProvider.of<SearchBloc>(context).placemark!;
QuerySnapshot<Map<String, dynamic>> instance=await FirebaseFirestore.instance.collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection).get();
List<RoomModel> data=instance.docs.map((e) {
return RoomModel.fromMap(e.data(),e.id);
}).toList();
BlocProvider.of<SearchBloc>(context).listRoomModel=data;
}


// logout function

 userLogOut(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    await SharedPreferencesClass.deleteUserid();
    await SharedPreferencesClass.deleteUserEmail();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
      return UserLogin();
    }), (route) => false);
  }

  // favirote adding function
  favoriteLoading({required String userId})async{
    log('keri===');
    List<dynamic> favoriteRooms=[];
    var favInstance= await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreUserCollection)
          .doc(userId).get();
          log('${favInstance.data()}');
          
          if(favInstance.data()![FirebaseFirestoreConst.firebaseFireStoreFavorite] !=null){
            log('ooooooo');
            for(var i in favInstance.data()![FirebaseFirestoreConst.firebaseFireStoreFavorite]){
              log('ppppppppp');
              favoriteRooms.add(i);
            }
          }
          return favoriteRooms;
  }
}























// Future<LatLng?> getLatLongFromPlaceName(String placeName) async {
//   final Uri url = Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {
//     'address': placeName,
//     'key': 'AIzaSyDxsQHrEBXaTwgI6OcUxU_ncM5a64UFS1g',
//   });
//   final response = await http.get(url);
//   log('${response.body}');
//   final results = jsonDecode(response.body)['results'];
//   if (results.isNotEmpty) {
//     final geometry = results[0]['geometry'];
//     final location = geometry['location'];
//     return LatLng(location['lat'], location['lng']);
//   } else {
//     return null; // Handle not found cases
//   }
// }
