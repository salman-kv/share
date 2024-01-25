import 'package:flutter/material.dart';
import 'package:share/user/presentation/widgets/commen_widget.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class UserSignUpOtp extends StatelessWidget {
  const UserSignUpOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Verify OTP',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  CommonWidget().otpSingleBox(context),
                  CommonWidget().otpSingleBox(context),
                  CommonWidget().otpSingleBox(context),
                  CommonWidget().otpSingleBox(context),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin:const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: Styles().elevatedButtonDecration(),
                  child: ElevatedButton(
                      style: Styles().elevatedButtonStyle(),
                      onPressed: () {},
                      child: Text(
                        'Verify',
                        style: Styles().elevatedButtonTextStyle(),
                      )),
                              ),
                              Text('resent OTP',style: Styles().linkTextColorStyle(context),)
                ],
              ),

            ],
          ),
        ),
      ),
    ));
  }
}
