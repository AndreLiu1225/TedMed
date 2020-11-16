import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tedmed2/enum/user_state.dart';
import 'package:tedmed2/models/user.dart';
import 'package:tedmed2/resources/firebase_methods.dart';
import 'package:tedmed2/utils/utilities.dart';

class OnlineDotIndicator extends StatelessWidget {
  final String uid;
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  OnlineDotIndicator({
    @required this.uid,
  });
  @override
  Widget build(BuildContext context) {
    getColor(int state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        default:
          return Colors.yellow;
      }
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: _firebaseMethods.getUserStream(
        uid: uid,
      ),
      builder: (context, snapshot) {
        User user;

        if (snapshot.hasData && snapshot.data.data != null) {
          user = User.fromMap(snapshot.data.data);
        }

        return Container(
          height: 10,
          width: 10,
          margin: EdgeInsets.only(right: 8, top: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getColor(user?.state),
          ),
        );
      },
    );
  }
}
