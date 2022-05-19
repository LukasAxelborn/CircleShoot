import 'package:flutter/material.dart';
import 'package:game/settings/user_settings/user_settings_option_state/user_settings_state.dart';

class SettingsOnlineCheckBox extends StatefulWidget {
  const SettingsOnlineCheckBox({Key? key}) : super(key: key);

  @override
  State<SettingsOnlineCheckBox> createState() => _SettingsOnlineCheckBoxState();
}

class _SettingsOnlineCheckBoxState extends State<SettingsOnlineCheckBox> {
  bool isChecked = UserSettingsState().getConnectOnline();

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
                UserSettingsState().setConnectOnline(isChecked);
              });
            },
          ),
        ],
      ),
    );
  }
}
