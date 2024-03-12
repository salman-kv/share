class FirebaseFirestoreConst {

  // user model fields
  static String firebaseFireStoreEmail = 'email';
  static String firebaseFireStorePassword = 'password';
  static String firebaseFireStoreName = 'name';
  static String firebaseFireStorePhone='phone';
  static String firebaseFireStoreImage='image';

  // collections
  static String firebaseFireStoreUserCollection = 'user';
  static String firebaseFireStoreRoomCollection = 'room';
  static String firebaseFireStoreSubAdminCollection = 'subadmin';
  static String firebaseFireStoreHotelCollection= 'hotel';
  static String firebaseFireStoreImages='images';
  // static String firebaseFireStoreBookedRoomCollection='bookedRoomCollection';
  static String firebaseFireStoreCurrentUserRoom='currentUserRoom';
  static String firebaseFireStoreCurrentUserCheckInRoom='currentUserInRoom';
  static String firebaseFireStoreCurrentBookedRoomCollection='currentBookedRoomCollection';
  static String firebaseFireStoreCurrentBookingAndPayAtHotelRoomCollection='currentBookingAndPayAtHotelRoomCollection';
    static String firebaseFireStoreRatingAndFeedback = 'ratingAndFeedback';



  // MainProperty model consts

   static String firebaseFireStoreHotelPlace='place';
   static String firebaseFireStoreHotelType='hotelType';
   static String firebaseFireStoreHotelLatLng='latlng';
   static String firebaseFireStoreHotelImages='images';


  // Room model const
  static String firebaseFireStoreHotelId='hotelId';
  static String firebaseFireStoreHotelName='hotelName';
  static String firebaseFireStoreRoomNumber='roomNumber';
  static String firebaseFireStoreRoomPrice='price';
  static String firebaseFireStoreNumberOfBed='numberOfBed';
  static String firebaseFireStoreRoomFeatures='Features';
  static String firebaseFireStoreRoomImages='images';
  static String firebaseFireStoreRoomAvailability='availability';
  static String firebaseFireStoreRooms='rooms';
  static String firebaseFireStoreRoomId='id';
  static String firebaseFireStoreCurrentBookedUser='currentBookedUserId';
  static String firebaseFireStoreCurrentBookeDeatails='currentBookedDeatails';
  static String firebaseFireStoreCurrentBookeDate='RoombookedDate';
  static String firebaseFireStorePaymentModel='paymentModel';


  // sort constant
  static String firebasefirestoreLowToHigh='LTH';
  static String firebasefirestoreHighToLow='HTL';

  // roomBooking model const 
  static String firebaseFireStoreUserId='userId';
  static String firebaseFireStoreBookedDates='bookedDates';
  static String firebaseFireStoreBookingDeatails='bookingDeatails';
  static String firebaseFireStoreBookingTime='bookingTime';
  static String firebaseFireStoreBookingPending='pending';
  static String firebaseFireStoreBookingId='bookingId';
  
  // payment model const
  static String firebaseFireStorePaymentId='paymentId';
  static String firebaseFireStorePaymentTime='paymentITime';
  static String firebaseFireStorePaymentAmount='paymenAmount';
  static String firebaseFireStorePaymentDeatails='paymenDeatails';

  // checkin checkout model 
  static String firebaseFireStoreCheckInTime='checkInTime';
  static String firebaseFireStoreCheckOutTime='checkOutTime';
  static String firebaseFireStoreCheckInORcheckOutRequest='request';
  static String firebaseFireStoreCheckInORcheckOutRequestForCheckInWaiting='checkInWaiting';
  static String firebaseFireStoreCheckInORcheckOutRequestForCheckInDone='checkInDone';
  static String firebaseFireStoreCheckInORcheckOutRequestForCheckOutWaiting='checkOutWaiting';
  static String firebaseFireStoreCheckInORcheckOutRequestForCheckOutDone='checkOutDone';
  static String firebaseFireStoreCheckInORcheckOutDeatails='checkInCheckOutDeatails';

  // notification
static String firebaseFireStoreNotification='notification';
static String firebaseFireStoreNotificationOpened='notificationOpened';
static String firebaseFireStoreNotificationPurpose='notificationPurpose';
static String firebaseFireStoreNotificationData='notificationData';
static String firebaseFireStoreNotificationTime='notificationTime';
static String firebaseFireStoreNotificationRoomBookingModel='notificationRoomBookingModel';


// rating and feedback
static String firebaseFireStoreRating='rating';
static String firebaseFireStoreFeedback='feedback';
  

}

