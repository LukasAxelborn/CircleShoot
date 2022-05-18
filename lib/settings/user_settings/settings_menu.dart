import 'package:flutter/material.dart';

import 'user_settings_options/settings_auto_forward_checkbox.dart';
import 'user_settings_options/settings_clear_leaderboard.dart';
import 'user_settings_options/settings_difficulty_slider.dart';
import 'user_settings_options/settings_online_checkbox.dart';
import 'user_settings_options/settings_username_change_textbox.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: const [
            CustomsRow(
              widget: SettingsUserNameChangeTextBox(),
            ),
            CustomsRow(
              widget: SettingsDifficultySlider(),
            ),
            CustomsRow(
              widget: SettingsAutoForwardCheckBox(),
            ),
            CustomsRow(
              widget: SettingsOnlineCheckBox(),
            ),
            CustomsRow(
              widget: SettingsClearLeaderBoard(),
            ),
          ],
        ),
      ),
    );
  }
}

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
