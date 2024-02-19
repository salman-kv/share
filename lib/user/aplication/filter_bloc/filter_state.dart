import 'package:share/user/domain/model/room_model.dart';

abstract class FilterState{}
class InitialFilterState extends FilterState{}
class RangeValueChangedFilterStare extends FilterState{}
class FeatureValueChangedFilterStare extends FilterState{}
class SubmitedFilterStare extends FilterState{}