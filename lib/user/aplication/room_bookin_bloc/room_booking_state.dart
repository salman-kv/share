abstract class RoomBookingState{}
class InitialRoomBookingState extends RoomBookingState{}
class RoomBookingLoadingState extends RoomBookingState{}
class RoomBookingDatePickedState extends RoomBookingState{}
class RoomBookingDeletedState extends RoomBookingState{}
class RoomBookingStartingPickedState extends RoomBookingState{}
class RoomBookingUpdatesSuccessState extends RoomBookingState{}
class RoomBookingErrorState extends RoomBookingState{
  final String text;

  RoomBookingErrorState({required this.text});
}
class RoomBookingSuccessState extends RoomBookingState{}
class RoomBookingCancelSuccessState extends RoomBookingState{} 
class RoomBookingBookNowAndPayAtHotelSuccessState extends RoomBookingState{} 
