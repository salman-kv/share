import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/user/domain/model/notification_model.dart';
import 'package:share/user/presentation/widgets/notification_widget.dart';

class NotificationScreen extends StatelessWidget {
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;
  NotificationScreen({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text('Notifications',style: Theme.of(context).textTheme.titleLarge,),),
      body: ListView(
        children: List.generate(data.data!.docs.length, (index) {
          return NotificationWidget().notificationContainer(
            context: context,
              notification:
                  NotificationModel.fromMap(data.data!.docs[index].data()));
        }),
      ),
    ));
  }
}