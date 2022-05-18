import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game/settings/app_settings/app_colors.dart';
import 'package:game/settings/app_settings/scores_tracker_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            SettingsUserNameChangeTextBox(),
            SettingsDifficultySlider(),
            SettingsAutoForwardCheckBox(),
            SettingsOnlineCheckBox(),
            SettingsClearLeaderBoard(),
          ],
        ),
      ),
    );
  }
}

class SettingsDifficultySlider extends StatefulWidget {
  const SettingsDifficultySlider({Key? key}) : super(key: key);

  @override
  State<SettingsDifficultySlider> createState() =>
      _SettingsDifficultySliderState();
}

class _SettingsDifficultySliderState extends State<SettingsDifficultySlider> {
  double _currentSliderValue = 1;

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

class SettingsClearLeaderBoard extends StatefulWidget {
  const SettingsClearLeaderBoard({Key? key}) : super(key: key);

  @override
  State<SettingsClearLeaderBoard> createState() =>
      _SettingsClearLeaderBoardState();
}

class _SettingsClearLeaderBoardState extends State<SettingsClearLeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showDataAlert();
      },
      color: Colors.blue,
      child: const Text(
        'Clear Leaderboard',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  showDataAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title: const Text(
            "Reset Leaderboard",
            style: TextStyle(fontSize: 24.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Are you sure?",
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScoresTrackerSingleton().clearList();
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: const Text(
                            "Confirm",
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class PopUpConfirmation extends StatefulWidget {
  const PopUpConfirmation({Key? key}) : super(key: key);

  @override
  State<PopUpConfirmation> createState() => PopUpConfirmationState();
}

class PopUpConfirmationState extends State<PopUpConfirmation> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: const Text(
        "Create ID",
        style: TextStyle(fontSize: 24.0),
      ),
      content: SizedBox(
        height: 400,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: const Text(
                  "Mension Your ID ",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Id here',
                      labelText: 'ID'),
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    // fixedSize: Size(250, 50),
                  ),
                  child: const Text(
                    "Submit",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Note'),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
                  ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
                  ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                  ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
                  'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                  ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
