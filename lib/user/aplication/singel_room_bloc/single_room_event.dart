abstract class SingleRoomEvent{}
class OnInitialRoomDeatailsAddingEvent extends SingleRoomEvent{
  final String id;

  OnInitialRoomDeatailsAddingEvent({required this.id});
}