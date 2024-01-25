import 'package:flutter/material.dart';
import 'package:share/user/presentation/pages/welcomeUser/user_welcome_more_2.dart';
import 'package:share/user/presentation/widgets/buttons.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class WelcomeUserMore extends StatelessWidget {
  const WelcomeUserMore({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/userMoreImage.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.4,
                          MediaQuery.of(context).size.width * 0.2),
                      bottomRight: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.7,
                          MediaQuery.of(context).size.width * 0.65),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? const Color.fromARGB(255, 126, 126, 126)
                            : const Color.fromARGB(255, 255, 255, 255),
                        blurRadius: 6,
                        blurStyle: BlurStyle.outer,
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.009,
                    ),
                    Text('Track Your Room',
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.009,
                    ),
                    Text(
                      'Dont worry you can find the perfect stay for you in the affordable and nearest one.',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const WelcomeUserMore2();
                },
              )),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: Styles().customNextButtonDecration(),
                  child: Styles().customNextButtonChild(),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
