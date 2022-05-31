import 'package:flutter/material.dart';

class CustomsRow extends StatelessWidget {
  final Widget widget;
  const CustomsRow({Key? key, required this.widget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: widget,
    );
  }
}
