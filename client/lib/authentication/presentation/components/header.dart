import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackButton(
          color: Theme.of(context).accentColor,
        ),
        const SizedBox(width: 0),
        Text(
          'Covid Vaccine Registration',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
