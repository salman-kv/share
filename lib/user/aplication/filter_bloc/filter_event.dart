import 'package:flutter/material.dart';
import 'package:share/user/aplication/filter_bloc/filter_bloc.dart';

abstract class FilterEvent{}
class OnChangeFilterPriceEvent extends FilterEvent{
  final RangeValues rangeValues;

  OnChangeFilterPriceEvent({required this.rangeValues});
}
class OnSubmitFilterEvent extends FilterEvent{
  final RangeValues rangeValues;
  final List<String> features;

  OnSubmitFilterEvent({required this.rangeValues, required this.features});

}

class FeatureAddingInFilterEvent extends FilterEvent{
  final String val;

  FeatureAddingInFilterEvent({required this.val});
}

// this clas is using when i remove the seach valure from controller 
// i need to remove the filter value also
class OnCancelSearchAndFilterRemoveEvent extends FilterEvent{}