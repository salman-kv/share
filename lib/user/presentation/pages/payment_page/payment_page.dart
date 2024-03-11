import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_bloc.dart';
import 'package:share/user/aplication/room_bookin_bloc/room_booking_event.dart';
import 'package:share/user/aplication/singel_room_bloc/single_room_bloc.dart';
import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
import 'package:share/user/domain/model/payment_model.dart';
import 'package:share/user/domain/model/room_booking_model.dart';
import 'package:share/user/presentation/alerts/snack_bars.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen(
      {required this.mainContext,
      required this.price,
      super.key,
      this.bookingId,
      this.roomBookingModel});
  final int price;
  final BuildContext mainContext;
  String? bookingId;
  RoomBookingModel? roomBookingModel;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay razorpay = Razorpay();
  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    super.initState();
  }

  @override
  Widget build(mainContext) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pay with Razorpay',
            ),
            ElevatedButton(
              onPressed: () {
                var options = {
                  'key': 'rzp_test_1DP5mmOlF5G5ag',
                  'amount': widget.price * 100,
                  'name': 'share.',
                  'description': BlocProvider.of<UserLoginBloc>(
                                  widget.mainContext)
                              .userModel !=
                          null
                      ? '${BlocProvider.of<UserLoginBloc>(widget.mainContext).userModel!.name}  Room Booking'
                      : '',
                  'retry': {'enabled': true, 'max_count': 1},
                  'prefill': {
                    'contact': '8129431955',
                    'email': 'salu003kv@gmail.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                try {
                  razorpay.open(options);
                } catch (e) {
                  log('$e');
                }
              },
              child: const Text("Pay with Razorpay"),
            ),
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    SnackBars().errorSnackBar('payment error retry', widget.mainContext);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    log('${response.data}');
    log('${response.orderId}');
    log('${response.paymentId}');
    log('${response.signature}');
    if (widget.bookingId != null) {
      BlocProvider.of<RoomBookingBloc>(widget.mainContext).add(
          OnDeleateRoomBooking(
              roomBookingModel: widget.roomBookingModel!,
              bookingId: widget.bookingId!,
              userId: widget.mainContext.read<UserLoginBloc>().userId!));
    }
    BlocProvider.of<RoomBookingBloc>(widget.mainContext).add(
        OnClickRoomBookingPayButton(
            roomBookingModel: RoomBookingModel(
              bookingId: '',
                hotelId: widget.mainContext
                    .read<SingleRoomBloc>()
                    .roomModel!
                    .hotelId,
                roomId:
                    widget.mainContext.read<SingleRoomBloc>().roomModel!.id!,
                userId: widget.mainContext.read<UserLoginBloc>().userId!,
                roomNumber: widget.mainContext
                    .read<SingleRoomBloc>()
                    .roomModel!
                    .roomNumber,
                price: widget.price,
                bookedDate: {
                  'start':
                      widget.mainContext.read<RoomBookingBloc>().startingDate!,
                  'end': widget.mainContext.read<RoomBookingBloc>().endingDate!,
                },
                bookingTime: DateTime.now(),
                image: widget.mainContext
                    .read<SingleRoomBloc>()
                    .roomModel!
                    .images[0],
                paymentModel: PaymentModel(
                    paymentId: response.paymentId!,
                    paymentTime: DateTime.now(),
                    amount: widget.price),
                checkInCheckOutModel: null)));

    SnackBars().successSnackBar('Paylment success', widget.mainContext);
    Navigator.pop(widget.mainContext);
  }
}

  // void handleExternalWalletSelected(ExternalWalletResponse response) {
  //   showAlertDialog(
  //       widget.mainContext, "External Wallet Selected", "${response.walletName}");
  // }

  // void showAlertDialog(BuildContext context, String title, String message) {
  //   // set up the buttons
  //   Widget continueButton = ElevatedButton(
  //     child: const Text("Continue"),
  //     onPressed: () {
  //       Navigator.pop(widget.mainContext);
  //     }
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //     actions: [
  //       continueButton,
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: widget.mainContext,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
// }


// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:upi_india/upi_app.dart';
// import 'package:upi_india/upi_india.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   List<UpiApp>? apps;
//   UpiIndia _upiIndia = UpiIndia();

//   @override
//   void initState() {
//     _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
//       setState(() {
//         apps = value;
//       });
//     }).catchError((e) {
//       apps = [];
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: List.generate(apps == null ? 0 : apps!.length, (index) {
//             return Container(
//               child: ElevatedButton(
//                   onPressed: ()async {
//                    var re=await initiateTransaction(apps![index]);
//                    log('${re}');
//                    log('resopns code ${re.responseCode}');
//                    log(  ' transaction id${re.transactionId}'); 
//                    log('${re.responseCode}'); 
//                   },
//                   child: Text('${apps![index].name}')),
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   // ""

//   Future<UpiResponse> initiateTransaction(UpiApp app) async {
//     return _upiIndia.startTransaction(
//       app: app,
//       receiverUpiId: "7994298210@paytm",
//       receiverName: 'salman kv',
//       transactionRefId: 'TestingUpiIndiaPlugin',
//       transactionNote: 'Not actual. Just an example.',
//       amount: 1,
//     );
//   }
// }
