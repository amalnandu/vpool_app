import 'package:flutter/material.dart';

///////       App bar style, add this to flexible space property          /////////////

class Appbarstylining extends StatelessWidget {
  const Appbarstylining({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54, // shadow color
                blurRadius: 20, // shadow radius
                offset: Offset(5, 5), // shadow offset
                spreadRadius:
                    0.1, // The amount the box should be inflated prior to applying the blur
                blurStyle: BlurStyle.normal // set blur style
                ),
          ],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.cyan, Colors.green])),
    );
  }
}
