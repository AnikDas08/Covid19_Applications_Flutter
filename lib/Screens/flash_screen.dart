import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math'as math;

import 'world_servey.dart';

class FlasScr extends StatefulWidget {
  const FlasScr({super.key});

  @override
  State<FlasScr> createState() => _FlasScrState();
}

class _FlasScrState extends State<FlasScr> with SingleTickerProviderStateMixin{
  late final AnimationController controller=AnimationController
    (
      vsync: this,
      duration: Duration(seconds: 3))..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:5),(){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>WorldScreen()),);});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Center(
              child: AnimatedBuilder
                (

                  animation: controller,
                        builder: (BuildContext context,Widget? child){
              return Transform.rotate
                (
                angle: controller.value * 2.0 * math.pi,
                child: child,
              );
                        },
                  child: Container(
                    height: 200,
                    width: 201,
                    child: Center
                      (child: Image(image: AssetImage(
                        "image/virus.png"
                    ))
                    ),
                  ),
                  ),
            ),
            SizedBox(height: 20,),
            Text("Covid 19",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
