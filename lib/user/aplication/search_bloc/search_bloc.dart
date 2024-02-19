import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/user/aplication/search_bloc/search_event.dart';
import 'package:share/user/aplication/search_bloc/search_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String? searchText = '';
  bool visibility = false;
  LatLng? position;
  Placemark? placemark;
  List<RoomModel> listRoomModel = [];
  List<String>? features;
  RangeValues? rangeValues;
  SearchBloc() : super(InitialSearchState()) {
    on<OnChangeSearchEvent>((event, emit) {
      log(event.text);
      searchText = event.text;
      emit(OnChangeSearchState());
    });
    on<OnTapSearchEvent>((event, emit) {
      if (visibility != true) {
        visibility = true;
        emit(OnTappedSearchhState());
      }
    });
    on<InitialRoomFetchingSearchEvent>((event, emit) async {
      log('calling');
      emit(RoomDeatailsLoadingSearchhState());
      QuerySnapshot<Map<String, dynamic>> instance = await FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .get();
      List<RoomModel> roomsDeatails = instance.docs.map((e) {
        return RoomModel.fromMap(e.data());
      }).toList();
      listRoomModel.clear();
      listRoomModel.addAll(roomsDeatails);
      emit(RoomDeatailsSuccessSearchhState());
    });
    on<OnRoomDeatailsFilteringEvent>((event, emit) async {
      listRoomModel.clear();
      emit(RoomDeatailsLoadingSearchhState());
      QuerySnapshot<Map<String, dynamic>> instance = await FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .get();
      List<RoomModel> roomsDeatails = instance.docs.map((e) {
        return RoomModel.fromMap(e.data());
      }).toList();
      // filter by the search name first
      if (searchText != '' || searchText != null) {
        log('$searchText');
        for(RoomModel singleRoomModel in roomsDeatails){
          log('${singleRoomModel.place}');
          log('$searchText');
          if(singleRoomModel.place!.contains(searchText!)){
            listRoomModel.add(singleRoomModel);
          }
        }
      }
      log('over the text filter');
      if(features != null){
        log('${features}');
        for(int i=0;i<listRoomModel.length;i++){
          bool check=false;
          for(int j=0;j<features!.length;j++){
            if(!listRoomModel[i].features.contains(features![j])){
              check=true;
            }
            if(check){
              listRoomModel.remove(listRoomModel[i]);
              i--;
            }
          }
        }
      }
      log('after  filtering ');
      log('${listRoomModel}');
      emit(RoomDeatailsSuccessSearchhState());
    });
    on<FilterDeatailsAddingEvent>((event, emit){
      emit(RoomDeatailsLoadingSearchhState());
      features=event.features;
      rangeValues=event.rangeValues;
      emit(RoomDeatailsSuccessSearchhState());
    });
  }
}
