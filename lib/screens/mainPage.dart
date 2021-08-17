import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:movie_app/provider/signInProvider.dart';
import 'package:movie_app/screens/homePage.dart';
import 'package:provider/provider.dart';

import 'loginPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => signInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<signInProvider>(context);
            if (provider.isSigningIn)
              return LoadingIndicator();
            else if (snapshot.hasData)
              return HomePage();
            else
              return LoginPage();
          },
        ),
      ),
    );
  }
}

Widget LoadingIndicator() {
  return Container(
    alignment: Alignment.center,
    child: LoadingBouncingGrid.circle(
      backgroundColor: Colors.blue,
      size: 60.0,
      duration: Duration(milliseconds: 5000),
    ),
  );
}
