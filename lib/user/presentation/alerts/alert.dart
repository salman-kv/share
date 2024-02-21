

import 'package:flutter/material.dart';
import 'package:share/user/domain/functions/user_firestroe_funciton.dart';
import 'package:share/user/domain/functions/user_function.dart';

class Alerts {
  dialgForDelete(
      {required BuildContext context,
      String? hotelId,
      String? roomId,
      required String type,}) {
    return showDialog(
        context: context,
        builder: (ctx) {
          String? dialog;
          // if (roomModel != null) {
          //   dialog =
          //       'Do you want to remove ${roomModel.roomNumber} room from ${roomModel.hotelName}';
          // } else if (propertyModel != null) {
          //   dialog =
          //       'Do you want to remove  " ${propertyModel.propertyNmae} "  this property';
          
          // } else 
          if (type == 'logOut') {
            dialog =
                'Do you want to LogOut';
          }
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 238, 237, 235),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(
              children: [
                const Icon(
                  Icons.warning,
                  color: Color.fromARGB(255, 244, 67, 54),
                  size: 29,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  dialog.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    if(type=='logOut'){
                      UserFireStroreFunction().userLogOut(context);
                    }
                  },
                  child: Text(
                    'Yes',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.green),
                  )),
            ],
          );
        });
  }
}
