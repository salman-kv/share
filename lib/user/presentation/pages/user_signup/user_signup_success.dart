import 'package:flutter/material.dart';

class UserSignUpsuccess extends StatelessWidget {
  const UserSignUpsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      'Welcome, salman',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: Text(
                        'You are all set now, Lets find your perfect room with us',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ));
  }
}
