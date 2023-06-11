import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SnapshotErrorPage extends StatelessWidget {
  const SnapshotErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(202, 235, 35, 35),
        title: const Center(
            child: Text(
          'Clever Modern Login Page',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
            fontFamily: 'PoltawaskiNowy',
          ),
        )),
      ),
      body: ColoredBox(
        color: const Color.fromARGB(255, 255, 235, 224),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PreferredSize(
              preferredSize:
                  Size(screenSize.width / 0.5, screenSize.height / 0.5),
              child: const Image(image: AssetImage('assets/_image_modern.jpg')),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: const Text(
                  'Connection Error',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 35.0,
                    fontFamily: 'PoltawaskiNowy',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
