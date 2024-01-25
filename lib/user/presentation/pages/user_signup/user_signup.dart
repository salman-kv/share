import 'package:flutter/material.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class UserSignUp extends StatelessWidget {
  const UserSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    'Hey there,',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Form(
                child: Column(
              children: [
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: ClipRRect(
                //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                //     child: TextFormField(
                //       decoration: Styles().formDecrationStyle(
                //           icon: const Icon(Icons.person_2_sharp),
                //           labelText: 'First name'),
                //       style: Styles().formTextStyle(),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: ClipRRect(
                //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                //     child: TextFormField(
                //       decoration: Styles().formDecrationStyle(
                //           icon: const Icon(Icons.person_outline),
                //           labelText: 'Last name'),
                //       style: Styles().formTextStyle(),
                //     ),
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: TextFormField(
                      decoration: Styles().formDecrationStyle(
                          icon: const Icon(Icons.mail_outline_rounded),
                          labelText: 'Email'),
                      style: Styles().formTextStyle(),
                    ),
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   child: ClipRRect(
                //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                //     child: TextFormField(
                //       obscureText: true,
                //       decoration: Styles().formDecrationStyle(
                //           icon: const Icon(Icons.lock_outline_rounded),
                //           labelText: 'Password'),
                //       style: Styles().formTextStyle(),
                //     ),
                //   ),
                // ),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {
                        value!;
                      },
                    ),
                    Expanded(
                      child: Text(
                        'By continuing you accept our Privacy policy and terms of use',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.grey),
                      ),
                    )
                  ],
                ),
                 SizedBox(height: MediaQuery.of(context).size.height >786 ? MediaQuery.of(context).size.height*0.63 : MediaQuery.of(context).size.height*.45 ,),
                Container(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: Styles().elevatedButtonDecration(),
                  child: ElevatedButton(
                      style: Styles().elevatedButtonStyle(),
                      onPressed: () {},
                      child: Text(
                        'Register',
                        style: Styles().elevatedButtonTextStyle(),
                      )),
                ),
              ],
            ))
          ],
        ),
      )),
    ));
  }
}
