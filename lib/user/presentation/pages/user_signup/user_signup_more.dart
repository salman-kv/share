import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:share/user/presentation/widgets/styles.dart';

class UserSignUpMoreInfo extends StatelessWidget {
  const UserSignUpMoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      "Let's Complete Your profile",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'It will help us to know more about you!,',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: TextFormField(
                    decoration: Styles().formDecrationStyle(
                        icon: const Icon(Icons.person_2_sharp),
                        labelText: 'First name'),
                    style: Styles().formTextStyle(),
                  ),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 300,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  buttonStyleData: ButtonStyleData(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.92,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 242, 242, 242),
                    ),
                  ),
                  onChanged: (value) {},
                  hint: const Row(
                    children: [
                      Icon(Icons.male_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Gender'),
                    ],
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: TextFormField(
                    decoration: Styles().formDecrationStyle(
                        icon: const Icon(Icons.phone_in_talk_outlined),
                        labelText: 'Phone'),
                    style: Styles().formTextStyle(),
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: TextFormField(
                      obscureText: true,
                      decoration: Styles().formDecrationStyle(
                          icon: const Icon(Icons.lock_outline_rounded),
                          labelText: 'Password'),
                      style: Styles().formTextStyle(),
                    ),
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add Image'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/profile.png'))),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.22,
              // ),
              Container(
                margin: const EdgeInsets.all(20),
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
            ],
          ),
        ),
      ),
    ));
  }
}
