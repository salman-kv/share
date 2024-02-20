import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/user/aplication/search_bloc/search_event.dart';
import 'package:share/user/aplication/search_bloc/search_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/enum/hotel_type.dart';
import 'package:share/user/domain/model/room_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String? searchText = '';
  bool visibility = false;
  LatLng? position;
  Placemark? placemark;
  List<RoomModel> listRoomModel = [];
  List<String>? features;
  RangeValues? rangeValues;
  List<Map<String, dynamic>> list = [
    {'name': 'All', 'select': true},
    {'name': 'Hotel', 'select': false},
    {'name': 'Dormetiory', 'select': false}
  ];
  String? sort;
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
    on<OnSortEvent>((event, emit) {
      emit(RoomDeatailsLoadingSearchhState());
      if (event.text == FirebaseFirestoreConst.firebasefirestoreLowToHigh) {
        listRoomModel.sort((a, b) => a.price - b.price);
      } else if (event.text ==
          FirebaseFirestoreConst.firebasefirestoreHighToLow) {
        listRoomModel.sort((b, a) => a.price - b.price);
      }
      sort = event.text;
      log('${listRoomModel}');
      emit(RoomDeatailsSuccessSearchhState());
    });
    on<OnCancelSearchEvent>((event, emit) {
      visibility = false;
      searchText = null;
      features = null;
      rangeValues = null;
      sort=null;
      list = [
        {'name': 'All', 'select': true},
        {'name': 'Hotel', 'select': false},
        {'name': 'Dormetiory', 'select': false}
      ];
      emit(InitialSearchState());
    });
    on<InitialRoomFetchingSearchEvent>((event, emit) async {
      log('calling');
      emit(RoomDeatailsLoadingSearchhState());
      QuerySnapshot<Map<String, dynamic>> instance = await FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .get();
      List<RoomModel> roomsDeatails = instance.docs.map((e) {
        return RoomModel.fromMap(e.data(), e.id);
      }).toList();
      listRoomModel.clear();
      listRoomModel.addAll(roomsDeatails);
      emit(RoomDeatailsSuccessSearchhState());
    });
    on<OnRoomDeatailsFilteringEvent>((event, emit) async {
      sort=null;
      listRoomModel.clear();
      emit(RoomDeatailsLoadingSearchhState());
      QuerySnapshot<Map<String, dynamic>> instance = await FirebaseFirestore
          .instance
          .collection(FirebaseFirestoreConst.firebaseFireStoreRoomCollection)
          .get();
      List<RoomModel> roomsDeatails = instance.docs.map((e) {
        return RoomModel.fromMap(e.data(), e.id);
      }).toList();
      // filter by the search name first
      if (searchText != '' || searchText != null) {
        for (RoomModel singleRoomModel in roomsDeatails) {
          if (singleRoomModel.place!.toLowerCase().contains(searchText!.toLowerCase())) {
            listRoomModel.add(singleRoomModel);
          }
        }
      }
      log('over the text filter');
      if (features != null) {
        for (int i = 0; i < listRoomModel.length; i++) {
          log('room features');
          log('${listRoomModel[i].features}');
          bool check = false;
          for (int j = 0; j < features!.length; j++) {
            if (!listRoomModel[i].features.contains(features![j])) {
              check = true;
            }
          }
          if (check) {
            listRoomModel.remove(listRoomModel[i]);
            i--;
          }
        }
      }
      if (rangeValues != null) {
        for (int i = 0; i < listRoomModel.length; i++) {
          if (listRoomModel[i].price < rangeValues!.start ||
              listRoomModel[i].price > rangeValues!.end) {
            listRoomModel.removeAt(i);
            i--;
          }
        }
      }
      if (list[1]['select'] == true) {
        for (int i = 0; i < listRoomModel.length; i++) {
          if (!(listRoomModel[i].roomType == HotelType.hotel)) {
            listRoomModel.removeAt(i);
            i--;
          }
        }
      } else if (list[2]['select'] == true) {
        for (int i = 0; i < listRoomModel.length; i++) {
          if (!(listRoomModel[i].roomType == HotelType.dormitory)) {
            listRoomModel.removeAt(i);
            i--;
          }
        }
      }
      emit(RoomDeatailsSuccessSearchhState());
    });
    on<FilterDeatailsAddingEvent>((event, emit) {
      emit(RoomDeatailsLoadingSearchhState());
      features = event.features;
      rangeValues = event.rangeValues;
      emit(RoomDeatailsSuccessSearchhState());
    });
    on<OnTapCatogoryChangeEvent>((event, emit) {
      emit(RoomDeatailsLoadingSearchhState());
      for (int i = 0; i < list.length; i++) {
        if (i == event.index) {
          list[i]['select'] = true;
        } else {
          list[i]['select'] = false;
        }
      }
      emit(CatogoryChangedSearchState());
    });
  }
}
