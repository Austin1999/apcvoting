import 'package:flutter/material.dart';
import 'package:webapp/login_page.dart';

class ThankyouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Thanks for Voting ',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Center(
              child: Text(
                'Your vote was submitted successfully',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'Back to Home',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
