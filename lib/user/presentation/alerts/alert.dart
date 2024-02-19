

// import 'package:flutter/material.dart';

// class Alerts {
//   dialgForDelete(
//       {required BuildContext context,
//       String? hotelId,
//       String? roomId,
//       MainPropertyModel? propertyModel,
//       required String type,
//       RoomModel? roomModel}) {
//     return showDialog(
//         context: context,
//         builder: (ctx) {
//           String? dialog;
//           if (roomModel != null) {
//             dialog =
//                 'Do you want to remove ${roomModel.roomNumber} room from ${roomModel.hotelName}';
//           } else if (propertyModel != null) {
//             dialog =
//                 'Do you want to remove  " ${propertyModel.propertyNmae} "  this property';
          
//           } else if (type == 'logOut') {
//             dialog =
//                 'Do you want to LogOut';
//           }
//           return AlertDialog(
//             backgroundColor: const Color.fromARGB(255, 238, 237, 235),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             title: Column(
//               children: [
//                 const Icon(
//                   Icons.warning,
//                   color: Color.fromARGB(255, 244, 67, 54),
//                   size: 29,
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   dialog.toString(),
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.displayMedium,
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     'No',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleMedium!
//                         .copyWith(color: Colors.red),
//                   )),
//               TextButton(
//                   onPressed: () async {
//                     if (type == 'roomDelete') {
//                       SubAdminFunction().deleteRoomFromHotel(
//                           hotelId: hotelId!, roomId: roomId!);
//                       Navigator.of(context).pop();
//                       SnackBars().successSnackBar(
//                           'Room deleted successfully', context);
//                     } else if (type == 'hotelDelete') {
//                       SubAdminFunction().deleteHotelFromSubAdmin(
//                           propertyModel: propertyModel!, hotelId: hotelId!);
//                       Navigator.of(context).pop();
//                       SnackBars().successSnackBar(
//                           'Property deleted successfully', context);
//                     }else if(type=='logOut'){
//                       SubAdminFunction().subAdminLogOut(context);
//                     }
//                   },
//                   child: Text(
//                     'Yes',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleMedium!
//                         .copyWith(color: Colors.green),
//                   )),
//             ],
//           );
//         });
//   }
// }
