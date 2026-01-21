import 'package:flutter/material.dart';

class MainMenuButtons extends StatelessWidget {
  const MainMenuButtons(
      {super.key,
      required this.color,
      required this.function,
      required this.text,
      required this.fontSize});
  final Color color;
  final VoidCallback function;
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withValues(alpha:0.5),
                  color.withValues(alpha:0.3),
                  color.withValues(alpha:0.5),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha:0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
          )),
    );
  }
}
