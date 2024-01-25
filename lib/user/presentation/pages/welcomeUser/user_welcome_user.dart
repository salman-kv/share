import 'package:flutter/material.dart';
import 'package:share/user/presentation/pages/welcomeUser/user_welcome_more.dart';
import 'package:share/user/presentation/widgets/designed_text.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class WelcomeUser extends StatelessWidget {
  const WelcomeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DesignedText().welcomeShareText(),
                  Text(
                    'Find Your safe stay',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
            // CustomButton().customSubmitButton(context, 'Get Start'),
            Container(
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: Styles().elevatedButtonDecration(),
              child: ElevatedButton(
                  style: Styles().elevatedButtonStyle(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const WelcomeUserMore();
                    },));
                  },
                  child: Text(
                    'Get Start',
                    style: Styles().elevatedButtonTextStyle(),
                  )),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    ));
  }
}
