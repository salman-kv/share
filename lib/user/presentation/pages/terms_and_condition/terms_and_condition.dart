import 'package:flutter/material.dart';
import 'package:share/user/presentation/const/const_text.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                TextConstants.terms1,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Use of the App',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                TextConstants.terms2,
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
                'User Content',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                TextConstants.terms3,
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
                'Intellectual Property Rights',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                TextConstants.terms4,
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
