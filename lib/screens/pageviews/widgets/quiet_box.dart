import 'package:flutter/material.dart';
import 'package:tedmed2/screens/search_screen.dart';
import 'package:tedmed2/utils/universal_variables.dart';

class QuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your chats are listed here..",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 25,),
            Text(
              "Search for your doctors name to start chatting or calling with them",
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 25),
            FlatButton(
              color: UniversalVariables.lightBlueColor,
              child: Text("Start Searching"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}