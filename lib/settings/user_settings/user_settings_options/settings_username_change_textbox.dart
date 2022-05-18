import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_settings/app_colors.dart';

class SettingsUserNameChangeTextBox extends StatefulWidget {
  const SettingsUserNameChangeTextBox({Key? key}) : super(key: key);

  @override
  State<SettingsUserNameChangeTextBox> createState() =>
      _SettingsUserNameChangeTextBoxState();
}

class _SettingsUserNameChangeTextBoxState
    extends State<SettingsUserNameChangeTextBox> {
  String hintText = "AAAAA";
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

  @override
  void initState() {
    super.initState();

    _getUserName();
  }

  Future<void> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final _userName = prefs.getString('USERNAME');
    if (_userName != null) {
      setState(
        () {
          hintText = _userName;
        },
      );
    }
  }

  Future<void> _setUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('USERNAME', _textController.text);
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
                  fontSize: 20,
                  color: AppColors.ok,
                  background: Paint()..color = AppColors.menuText,
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
