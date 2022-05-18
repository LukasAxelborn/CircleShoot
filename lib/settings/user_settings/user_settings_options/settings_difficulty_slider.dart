import 'package:flutter/material.dart';
import 'package:game/settings/user_settings/user_settings_option_state/user_settings_state.dart';

class SettingsDifficultySlider extends StatefulWidget {
  const SettingsDifficultySlider({Key? key}) : super(key: key);

  @override
  State<SettingsDifficultySlider> createState() =>
      _SettingsDifficultySliderState();
}

class _SettingsDifficultySliderState extends State<SettingsDifficultySlider> {
  double _currentSliderValue = UserSettingsState().getDifficulty().toDouble();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Difficulty:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        Slider(
          value: _currentSliderValue,
          max: 2,
          divisions: 2,

          ///label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              UserSettingsState().setDifficulty(value.toInt());
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Easy",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'Middel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'Hard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
