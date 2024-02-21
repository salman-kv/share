import 'package:flutter/material.dart';

abstract class MapEvent{}
class OnFechHotelDeatailsEvent extends MapEvent{
  final BuildContext context;

  OnFechHotelDeatailsEvent({required this.context});
}

class OnCamaraPositionChangeEvent extends MapEvent{
}