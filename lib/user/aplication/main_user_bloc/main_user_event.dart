abstract class MainUserEvent{}
class OnNavBarClickedEvent extends MainUserEvent{
  final int index;

  OnNavBarClickedEvent({required this.index});
}

class OnColorChangeEvent extends MainUserEvent{
  final int index;

  OnColorChangeEvent({required this.index});
  
}
class OnSelectColorBySharedPrefrence extends MainUserEvent{
  final int index;

  OnSelectColorBySharedPrefrence({required this.index});
}