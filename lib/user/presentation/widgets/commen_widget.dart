import 'package:flutter/material.dart';

class CommonWidget {
  otpSingleBox(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(10),
      height: 60,
      width: MediaQuery.of(context).size.width * .14,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Center(
        child: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      ),
    );
  }
}
