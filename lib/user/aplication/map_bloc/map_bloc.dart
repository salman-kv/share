import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/user/aplication/map_bloc/map_event.dart';
import 'package:share/user/aplication/map_bloc/map_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/functions/user_firestroe_funciton.dart';
import 'package:share/user/domain/model/main_property_model.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';
import 'package:share/user/presentation/widgets/common_widget.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  LatLng? userPosition;
  var initialCameraPosition =
      const CameraPosition(target: LatLng(12.44, 20.445), zoom: 14);
  Set<Marker> marker = {};
  List<MainPropertyModel> listOfHotel = [];
  GoogleMapController? controller;
  MapBloc() : super(MapInitialState()) {
    on<OnFechHotelDeatailsEvent>((event, emit) async {
      log('starting');
      emit(MapLoadingState());
      userPosition =
          await UserFireStroreFunction().getCurrentLocation(event.context);
      var instance = await FirebaseFirestore.instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreHotelCollection)
          .get();
      List<MainPropertyModel> hotelDeatails = instance.docs.map((e) {
        return MainPropertyModel.fromMap(e.data(), e.id);
      }).toList();
      listOfHotel.clear();
      listOfHotel.addAll(hotelDeatails);
      marker.clear();
      BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(0, 0)),
          'assets/images/home2.png');
      for (MainPropertyModel i in listOfHotel) {
        marker.add(
          Marker(
            markerId: MarkerId('${i.id}'),
            position: i.latLng,
            icon: customMarker,
            infoWindow: InfoWindow(
              title: i.propertyNmae,
              onTap: () {
                CommonWidget().hotelBottomSheet(
                    context: event.context, mainPropertyModel: i);
              },
            ),
            onTap: () {},
          ),
        );
      }
      marker.add(Marker(
          markerId: MarkerId('Current Location'), position: userPosition!));
      log('everithing is okey');
      emit(MapSuccessState());
    });
    on<OnCamaraPositionChangeEvent>((event, emit) {
      controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: userPosition!, zoom: 15),
        ),
      );
      emit(MapSuccessState());
    });
  }
}
