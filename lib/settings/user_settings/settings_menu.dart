import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game/settings/app_settings/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
        ),
      ),
    );
  }
}
