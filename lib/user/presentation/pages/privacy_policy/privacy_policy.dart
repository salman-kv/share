import 'package:flutter/material.dart';
import 'package:share/user/presentation/const/const_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                TextConstants.privacy1,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Information We Collect',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                TextConstants.privacy2,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text('How We Use Your Information',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                TextConstants.privacy3,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Data Security',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                TextConstants.privacy4,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
