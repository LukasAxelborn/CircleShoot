import 'package:flutter/material.dart';
import 'package:game/online_game/online_game_create/online_game_create_state/online_game_create_state.dart';

import '../../../widgets/good_text_style.dart';

class OnlineGameSettingsNumberofPlayers extends StatefulWidget {
  const OnlineGameSettingsNumberofPlayers({Key? key}) : super(key: key);

  @override
  State<OnlineGameSettingsNumberofPlayers> createState() =>
      _OnlineGameSettingsNumberofPlayersState();
}

class _OnlineGameSettingsNumberofPlayersState
    extends State<OnlineGameSettingsNumberofPlayers> {
  double _currentSliderValue =
      OnlineGameCreateState().getnumberofplayers().toDouble();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        goodTextStyle("Number of Players:"),
        Slider(
          value: _currentSliderValue,
          min: 2,
          max: 4,
          divisions: 2,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              OnlineGameCreateState().setnumberofplayers(
                _currentSliderValue.toInt(),
              );
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            goodTextStyle("    2"),
            goodTextStyle("3"),
            goodTextStyle("4   "),
          ],
        ),
      ],
    );
  }
}
