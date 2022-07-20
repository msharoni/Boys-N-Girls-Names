import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ConfettiSample());

class ConfettiSample extends StatelessWidget {
  const ConfettiSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Confetti',
        home: Scaffold(
          backgroundColor: Colors.grey[900],
          body: MyApp(),
        ));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerCenterRight;

  @override
  void initState() {
    super.initState();

    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _controllerCenterLeft.dispose();
    _controllerCenterRight.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    _controllerCenterLeft.play();
    _controllerCenterRight.play();
    return SafeArea(
      child: Stack(
        children: <Widget>[
          //CENTER -- Blast

          //CENTER LEFT - Emit right
          Align(
            alignment: Alignment.topLeft,
            child: ConfettiWidget(
              shouldLoop: true,
              confettiController: _controllerCenterLeft,
              blastDirection: 0, // radial value - RIGHT
              emissionFrequency: 0.6,
              minBlastForce: 1,
              minimumSize: const Size(10,
                  10), // set the minimum potential size for the confetti (width, height)
              maximumSize: const Size(50,
                  50), // set the maximum potential size for the confetti (width, height)
              numberOfParticles: 1,
              gravity: 0.9, // gravity value for the confetti to fall down
            ),
          ),

          //CENTER Right - Emit left
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
              shouldLoop: true,
              confettiController: _controllerCenterRight,
              blastDirection: pi, // radial value - RIGHT
              emissionFrequency: 0.6,
              minBlastForce: 1,
              minimumSize: const Size(10,
                  10), // set the minimum potential size for the confetti (width, height)
              maximumSize: const Size(50,
                  50), // set the maximum potential size for the confetti (width, height)
              numberOfParticles: 1,
              gravity: 0.9, // gravity value for the confetti to fall down
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.blue,
                textColor: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Boy!",
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.pink,
                textColor: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Girl!",
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
