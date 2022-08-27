import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String hour = "00";
  String minute = "00";
  String second = "00";

  int sec = 0;
  int min = 0;
  int hr = 0;

  bool isAnalogClock = false;
  DateTime datetime = DateTime.now();

  initClock() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        sec++;
        if (sec == 60) {
          min++;
          sec = 0;
        }
        if (min == 60) {
          hr++;
          min = 0;
        }

        setState(() {
          second = sec.toString();
          minute = min.toString();
          hour = hr.toString();
        });
        initClock();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initClock();
    sec = datetime.second;
    min = datetime.minute;
    hr = datetime.hour;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _wight = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: _height,
            width: _wight,
            child: Image.asset(
              "assets/image/wp10316555-black-glass-wallpapers.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 25),
              alignment: Alignment.center,
              height: 60,
              width: _wight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.grey.withOpacity(0.2),
                  ],
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 140,
                  ),
                  Text(
                    "CLOCK",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 19,
                      letterSpacing: 7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isAnalogClock = !isAnalogClock;
                      });
                    },
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isAnalogClock)
            ...digitalClock(
              height: _height,
              wight: _wight,
            )
          else
            ...analogClock(
              height: _height,
              wight: _wight,
            ),
        ],
      ),
    );
  }

  List<Widget> digitalClock({required double height, required double wight}) {
    return [
      Container(
        alignment: Alignment.center,
        height: height * 0.35,
        width: wight * 0.65,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.grey.withOpacity(0.2),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(8, 8),
                blurRadius: 50,
                spreadRadius: 8,
                color: Colors.white.withOpacity(0.2),
              ),
            ]),
        child: Text(
          "$hour : $minute : $second",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 19,
            letterSpacing: 1,
          ),
        ),
      ),
      Transform.scale(
        scale: 3.5,
        child: CircularProgressIndicator(
          value: sec / 60,
          backgroundColor: Colors.transparent,
          color: Colors.amber,
          strokeWidth: 3,
        ),
      ),
      Transform.scale(
        scale: 4.5,
        child: CircularProgressIndicator(
          value: min / 60,
          backgroundColor: Colors.transparent,
          color: Colors.purple,
          strokeWidth: 3,
        ),
      ),
      Transform.scale(
        scale: 5.5,
        child: CircularProgressIndicator(
          value: hr / 12,
          backgroundColor: Colors.transparent,
          color: Colors.blue,
          strokeWidth: 3,
        ),
      ),
    ];
  }

  List<Widget> analogClock({required double height, required double wight}) {
    return [
      Container(
        alignment: Alignment.center,
        height: height * 0.35,
        width: wight * 0.65,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.grey.withOpacity(0.2),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(8, 8),
                blurRadius: 50,
                spreadRadius: 8,
                color: Colors.white.withOpacity(0.2),
              ),
            ]),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: (hr * (pi * 2) / 12) + pi / 2,
              child: Divider(
                color: Colors.amber,
                thickness: 4,
                indent: 45,
                endIndent: 115,
              ),
            ),
            Transform.rotate(
              angle: (min * (pi * 2) / 60) + pi / 2,
              child: Divider(
                color: Colors.red,
                thickness: 4,
                indent: 30,
                endIndent: 115,
              ),
            ),
            Transform.rotate(
              angle: pi/2,
              child: Divider(
                color: Colors.blueAccent,
                thickness: 4,
                indent: 15,
                endIndent: 115,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 600,

        child: Text(
          "$hour : $minute : $second",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 20,
            letterSpacing: 1,
          ),
        ),
      ),
    ];
  }
}
