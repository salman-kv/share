import 'package:flutter/material.dart';
import 'package:share/user/domain/model/room_model.dart';

abstract class SearchEvent{}
class OnChangeSearchEvent extends SearchEvent{
  final String text;

  OnChangeSearchEvent({required this.text});
}
class OnTapSearchEvent extends SearchEvent{
}
class InitialRoomFetchingSearchEvent extends SearchEvent{}
class FilterDeatailsAddingEvent extends SearchEvent{
  final RangeValues? rangeValues;
  final List<String>? features;

  FilterDeatailsAddingEvent({required this.rangeValues, required this.features});
}

class OnRoomDeatailsFilteringEvent extends SearchEvent{}