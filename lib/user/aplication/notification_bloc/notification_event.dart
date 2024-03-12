import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class NotificationEvent{}
class OnNotificationDataSnapshotEvent extends NotificationEvent{
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  OnNotificationDataSnapshotEvent({required this.snapshot});
}
class OnTapNotificationButtonEvent extends NotificationEvent{
   final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
final BuildContext context;

  OnTapNotificationButtonEvent({required this.snapshot, required this.context});

}