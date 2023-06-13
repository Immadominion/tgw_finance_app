import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

AppBar buildAppBar(context, String text) {
  return AppBar(
    backgroundColor: kNextIconColor,
    elevation: 0,
    title: Text(
      text,
      style: kBoldTextStyle,
    ),
    centerTitle: true,
  );
}

Padding buildProfileImageAvatar() {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0),
    child: Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
              // radius: 50.0,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 5,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  color: kNextIconColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: kColor,
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Padding buildMenuItem(IconData icon, String text, Function onpress) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    child: TextButton(
      style: TextButton.styleFrom(
          backgroundColor: Colors.grey[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onpress(),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: kColor,
          ),
          const SizedBox(width: 20.0),
          Text(
            text,
            style: kTextStyle,
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: kNextIconColor,
          ),
        ],
      ),
    ),
  );
}
