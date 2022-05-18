import 'package:flutter/material.dart';

class SettingsAutoForwardCheckBox extends StatefulWidget {
  const SettingsAutoForwardCheckBox({Key? key}) : super(key: key);

  @override
  State<SettingsAutoForwardCheckBox> createState() =>
      _SettingsAutoForwardCheckBoxState();
}

class _SettingsAutoForwardCheckBoxState
    extends State<SettingsAutoForwardCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };

      return Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Move Forward Atomatic",
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
