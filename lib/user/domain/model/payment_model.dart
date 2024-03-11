import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';

class PaymentModel {
  final String paymentId;
  final DateTime paymentTime;
  final int amount;

  PaymentModel(
      {required this.paymentId,
      required this.paymentTime,
      required this.amount});

  Map<String, dynamic> toMap() {
    return {
      FirebaseFirestoreConst.firebaseFireStorePaymentId: paymentId,
      FirebaseFirestoreConst.firebaseFireStorePaymentTime: paymentTime,
      FirebaseFirestoreConst.firebaseFireStorePaymentAmount: amount,
    };
  }

  static PaymentModel fromMap(Map<String, dynamic> map) {
    return PaymentModel(
        paymentId: map[FirebaseFirestoreConst.firebaseFireStorePaymentId],
        paymentTime: DateTime.fromMillisecondsSinceEpoch(map[FirebaseFirestoreConst.firebaseFireStorePaymentTime].seconds *1000),
        amount: map[FirebaseFirestoreConst.firebaseFireStorePaymentAmount]);
  }
}
