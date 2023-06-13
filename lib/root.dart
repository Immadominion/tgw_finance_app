import 'package:flutter/material.dart'
    show BuildContext, State, StatefulWidget, Widget;

import 'auth_functions_tgw/auth.dart';
import 'home.dart';
import 'auth_functions_tgw/login_signup.dart';

class Root extends StatefulWidget {
  const Root({super.key, required this.auth});

  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => _RootState();
}

enum AuthStat { invalid, loggedOut, loggedIn }

class _RootState extends State<Root> {
  static AuthStat authState = AuthStat.invalid;
  static String _id = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _id = user.uid;
        }
        authState = user?.uid == null ? AuthStat.loggedOut : AuthStat.loggedIn;
      });
    });
  }

  void loggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _id = user!.uid.toString();
        authState = AuthStat.loggedIn;
      });
    });
  }

  void loggedOut() {
    setState(() {
      authState = AuthStat.loggedOut;
      _id = '';
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   switch (authState) {
  //     case AuthStat.invalid:
  //       break;
  //     case AuthStat.loggedOut:
  //       return LoginSignUp(
  //         auth: widget.auth,
  //         loggedIn: loggedIn,
  //       );
  //     case AuthStat.loggedIn:
  //       if (_id.isNotEmpty) {
  //         return home(
  //           id: _id,
  //           auth: widget.auth,
  //           onsignOut: loggedOut,
  //         );
  //       }
  //       break;
  //     default:
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget result;

    switch (authState) {
      case AuthStat.invalid:
        result = LoginSignUp(
          auth: widget.auth,
          loggedIn: loggedIn,
        );
        break;

      case AuthStat.loggedOut:
        result = LoginSignUp(
          auth: widget.auth,
          loggedIn: loggedIn,
        );
        break;

      case AuthStat.loggedIn:
        if (_id.isNotEmpty) {
          result = Home(
            id: _id,
            auth: widget.auth,
            onSignOut: loggedOut,
          );
        } else {
          result = LoginSignUp(
            auth: widget.auth,
            loggedIn: loggedIn,
          );
          break; // or any other placeholder widget
        }
        break;

      default:
        result = LoginSignUp(
          auth: widget.auth,
          loggedIn: loggedIn,
        );
        break;
    }

    return result;
  }
}
