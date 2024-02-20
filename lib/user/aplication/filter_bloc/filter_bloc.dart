import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/user/aplication/filter_bloc/filter_event.dart';
import 'package:share/user/aplication/filter_bloc/filter_state.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/room_model.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  RangeValues? rangeValues = const RangeValues(0, 5000);
  RangeValues? tempRangeValues;
  List<String> features = [];
  List<String> tempFeatures = [];

  FilterBloc() : super(InitialFilterState()) {
    on<OnChangeFilterPriceEvent>((event, emit) {
      tempRangeValues = RangeValues(event.rangeValues.start.roundToDouble(),
          event.rangeValues.end.roundToDouble());
      emit(RangeValueChangedFilterStare());
    });
    on<OnSubmitFilterEvent>((event, emit) async {
      rangeValues = tempRangeValues;
      features.clear();
      features.addAll(tempFeatures);
      emit(SubmitedFilterStare());
    });
    on<FeatureAddingInFilterEvent>((event, emit) {
      if (tempFeatures.contains(event.val)) {
        tempFeatures.remove(event.val);
      } else {
        tempFeatures.add(event.val);
      }
      emit(FeatureValueChangedFilterStare());
    });
    on<OnCancelSearchAndFilterRemoveEvent>((event, emit) {
      features=[];
      rangeValues = const RangeValues(0, 5000);
      emit(FeatureValueChangedFilterStare());

    });
  }
}
