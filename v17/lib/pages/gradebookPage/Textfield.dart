import 'package:flutter/material.dart';
import 'package:v17/constants.dart';

class GradebookTextField extends StatelessWidget {
  const GradebookTextField({
    @required this.label,
    @required this.controller,
    @required this.icon,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(8),
        color:
            Constants.isBright(context) ? Colors.grey[200] : Colors.grey[800],
        child: Theme(
          data: ThemeData(
            primaryColor: Constants.primary,
            primaryColorDark: Constants.primary,
            accentColor: Colors.yellow,
            brightness: Constants.isBright(context)
                ? Brightness.light
                : Brightness.dark,
          ),
          child: TextField(
            obscureText: this.obscureText,
            controller: this.controller,
            decoration: InputDecoration(
              labelText: this.label,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(
                this.icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
