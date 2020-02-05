import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.lightBlueAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
