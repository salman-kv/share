import 'package:flutter/material.dart';

abstract class SearchEvent{}
class OnChangeSearchEvent extends SearchEvent{
  final String text;

  OnChangeSearchEvent({required this.text});
}
class OnTapSearchEvent extends SearchEvent{
}
class OnCancelSearchEvent extends SearchEvent{}
class InitialRoomFetchingSearchEvent extends SearchEvent{}
class FilterDeatailsAddingEvent extends SearchEvent{
  final RangeValues? rangeValues;
  final List<String>? features;

  FilterDeatailsAddingEvent({required this.rangeValues, required this.features});
}

class OnRoomDeatailsFilteringEvent extends SearchEvent{}
class OnTapCatogoryChangeEvent extends SearchEvent{
  final int index;

  OnTapCatogoryChangeEvent({required this.index});
}
class OnSortEvent extends SearchEvent{
  final String text;

  OnSortEvent({required this.text});
}