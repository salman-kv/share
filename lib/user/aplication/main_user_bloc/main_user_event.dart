abstract class MainUserEvent{}
class OnNavBarClickedEvent extends MainUserEvent{
  final int index;

  OnNavBarClickedEvent({required this.index});
}