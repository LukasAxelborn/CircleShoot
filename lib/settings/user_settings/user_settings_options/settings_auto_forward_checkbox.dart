import 'package:flutter/material.dart';

import '../user_settings_option_state/user_settings_state.dart';

class SettingsAutoForwardCheckBox extends StatefulWidget {
  const SettingsAutoForwardCheckBox({Key? key}) : super(key: key);

  @override
  State<SettingsAutoForwardCheckBox> createState() =>
      _SettingsAutoForwardCheckBoxState();
}

class _SettingsAutoForwardCheckBoxState
    extends State<SettingsAutoForwardCheckBox> {
  bool isChecked = UserSettingsState().getMoveForwardAutomatic();

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      /*
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.focused,
      };
      */

      return Colors.red;
    }

    return Row(
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
              UserSettingsState().setMoveForwardAutomatic(isChecked);
            });
          },
        ),
      ],
    );
  }
}
