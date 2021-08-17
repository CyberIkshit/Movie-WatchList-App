import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/provider/signInProvider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _login_PageState createState() => _login_PageState();
}

class _login_PageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/karma_logo.png',
                    //   height: 120,
                    //   width: 120,
                    // ),
                    Icon(
                      Icons.movie_creation_outlined,
                      size: 90,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Welcome to",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 26,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Movie Watchlist App",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Form(
              child: Container(
            // height: MediaQuery.of(context).size.height * 0.75,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            // color: Colors.black12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  _buildButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Please SignIn to continue",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ]),
          ))
        ]));
  }

  Widget _buildButton() {
    return SignInButton(
      Buttons.Google,
      elevation: 5,
      text: "Sign in with Google",
      onPressed: () {
        final provider = Provider.of<signInProvider>(context, listen: false);
        provider.login();
      },
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(50, height, width / 2, height);
    path.quadraticBezierTo(width - 50, height, width, height - 50);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
