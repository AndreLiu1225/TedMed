import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tedmed2/models/contact.dart';
import 'package:tedmed2/models/user.dart';
import 'package:tedmed2/provider/user_provider.dart';
import 'package:tedmed2/resources/firebase_methods.dart';
import 'package:tedmed2/screens/chatscreens/chat_screen.dart';
import 'package:tedmed2/screens/chatscreens/widgets/cached_image.dart';
import 'package:tedmed2/screens/pageviews/widgets/last_message_container.dart';
import 'package:tedmed2/screens/pageviews/widgets/online_dot_indicator.dart';
import 'package:tedmed2/utils/universal_variables.dart';
import 'package:tedmed2/widgets/custom_tile.dart';

class ContactView extends StatelessWidget {
  final Contact contact;
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  ContactView(this.contact);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _firebaseMethods.getUserDetailsById(contact.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return ViewLayout(
            contact: user,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ViewLayout extends StatelessWidget {
  final User contact;
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  ViewLayout({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return CustomTile(
      mini: false,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            receiver: contact,
          ),
        ),
      ),
      title: Text(
        contact?.name ?? "..",
        style:
            TextStyle(color: Colors.white, fontFamily: "Arial", fontSize: 19),
      ),
      subtitle: LastMessageContainer(
        stream: _firebaseMethods.fetchLastMessageBetween(
          senderId: userProvider.getUser.uid,
          receiverId: contact.uid,
        ),
      ),
      leading: Container(
        constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
        child: Stack(
          children: <Widget>[
            CachedImage(
              contact.profilePhoto,
              radius: 80,
              isRound: true,
            ),
            OnlineDotIndicator(
              uid: contact.uid
            ),
          ],
        ),
      ),
    );
  }
}
