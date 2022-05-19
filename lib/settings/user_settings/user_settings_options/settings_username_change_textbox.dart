import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game/settings/user_settings/user_settings_option_state/user_settings_state.dart';

import '../../app_settings/app_colors.dart';

class SettingsUserNameChangeTextBox extends StatefulWidget {
  const SettingsUserNameChangeTextBox({Key? key}) : super(key: key);

  @override
  State<SettingsUserNameChangeTextBox> createState() =>
      _SettingsUserNameChangeTextBoxState();
}

class _SettingsUserNameChangeTextBoxState
    extends State<SettingsUserNameChangeTextBox> {
  String hintText = UserSettingsState().getUserName();
  late bool saveText = false;
  final _textController = TextEditingController();

  void _showSaveText() {
    setState(() {
      saveText = true;
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        saveText = false;
      });
    });
  }

  void _getUserName() {
    setState(
      () {
        String _userName = UserSettingsState().getUserName();
        hintText = _userName;
      },
    );
  }

  void _setUserName() {
    setState(() {
      String _username = _textController.text;
      UserSettingsState().setUserName(_username);
      hintText = _username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "User name:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () => _textController.clear(),
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: saveText,
              child: Text(
                "Saved",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.ok,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                _setUserName();
                _getUserName();
                _showSaveText();
              },
              color: Colors.blue,
              child: const Text(
                'Save Name',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
