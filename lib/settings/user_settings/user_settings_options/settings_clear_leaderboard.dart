import 'package:flutter/material.dart';

import '../../app_settings/scores_tracker_singleton.dart';

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
