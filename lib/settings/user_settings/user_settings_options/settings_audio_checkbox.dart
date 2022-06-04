import 'package:flutter/material.dart';
import 'package:game/settings/user_settings/user_settings_option_state/user_settings_state.dart';

class SettingsAudioCheckBox extends StatefulWidget {
  const SettingsAudioCheckBox({Key? key}) : super(key: key);

  @override
  State<SettingsAudioCheckBox> createState() => _SettingsAudioCheckBoxState();
}

class _SettingsAudioCheckBoxState extends State<SettingsAudioCheckBox> {
  bool isChecked = UserSettingsState().getAudioSetting();

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
            "Enabel Audio",
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
                UserSettingsState().setAudioSetting(isChecked);
              });
            },
          ),
        ],
      ),
    );
  }
}
