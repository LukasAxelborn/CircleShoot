import 'package:flutter/material.dart';

class SettingsOnlineCheckBox extends StatefulWidget {
  const SettingsOnlineCheckBox({Key? key}) : super(key: key);

  @override
  State<SettingsOnlineCheckBox> createState() => _SettingsOnlineCheckBoxState();
}

class _SettingsOnlineCheckBoxState extends State<SettingsOnlineCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Connect Online",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
