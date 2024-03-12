import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:share/user/domain/const/firebasefirestore_constvalue.dart';
import 'package:share/user/domain/model/rating_and_feedback_model.dart';

class RatingAndFeedbackWidget {
  ratingFeedbackContainer(
      {required RatingAndFeedbackModel ratingAndFeedbackModel}) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(
                    FirebaseFirestoreConst.firebaseFireStoreUserCollection)
                .doc(ratingAndFeedbackModel.userid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  '${snapshot.data!.data()!['name']}',
                  style: Theme.of(context).textTheme.titleSmall,
                );
              } else {
                return const Text('no data');
              }
            },
          ),
          Row(
            children: List.generate(5, (index) {
              if (index <= ratingAndFeedbackModel.rating) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              } else {
                return const Icon(
                  Icons.star_border,
                  color: Colors.amber,
                );
              }
            }),
          ),
          Text(ratingAndFeedbackModel.feedback)
        ],
      ),
    );
  }
}
