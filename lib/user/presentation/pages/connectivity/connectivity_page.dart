import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConnectivityPage extends StatelessWidget {
  const ConnectivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Text('no internet connection'),
    ));
  }
}
