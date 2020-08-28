import 'package:flutter/material.dart';

class OrderConfirmedWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            buildThankYou(),
            Align(
              alignment: Alignment.bottomCenter,
              child: buildBackToHome(context),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildBackToHome(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context).pushNamedAndRemoveUntil('pizzaList', (Route<dynamic> route) => false),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          width: double.infinity,
          color: Colors.red,
          child: buildBackToHomeText(),
        ),
      );
  }

  Widget buildThankYou() {
    return Center(
      child: Text(
        "Thank you for your order",
        style: TextStyle(color: Colors.red, fontSize: 42),
        textAlign: TextAlign.center,
      ),
    );
  }

  Text buildBackToHomeText() {
    return Text(
      "Back to home",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

}