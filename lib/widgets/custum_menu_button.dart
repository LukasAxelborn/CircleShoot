import 'package:flutter/material.dart';

class CustumMenuButton extends StatelessWidget {
  final String buttonText;
  final Widget Function(BuildContext) fun;
  const CustumMenuButton(
      {Key? key, required this.buttonText, required this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 60))),
        child: ElevatedButton(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: fun),
            );
          },
        ),
      ),
    );
  }
}
