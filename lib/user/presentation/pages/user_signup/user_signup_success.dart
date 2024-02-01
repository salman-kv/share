import 'package:flutter/material.dart';
import 'package:share/user/presentation/pages/user_pages/user_home.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class UserSignUpsuccess extends StatelessWidget {
  const UserSignUpsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.asset(
                'assets/images/mapImage.jpg',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    'Welcome to Share',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      'You are all set now, Lets find your perfect room with us',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: Styles().elevatedButtonDecration(),
              child: ElevatedButton(
                  style: Styles().elevatedButtonStyle(),
                  onPressed: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) {
                      return  UserHome();
                    }), (route) => false);
                  },
                  child: Text(
                    'Finish',
                    style: Styles().elevatedButtonTextStyle(),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
