import 'package:flutter/material.dart';
import 'package:game/online_game/online_game_create/online_game_create_state/online_game_create_state.dart';

import '../../../settings/app_settings/app_colors.dart';
import '../../../widgets/good_text_style.dart';

class OnlineGameSettingsMatchTime extends StatefulWidget {
  const OnlineGameSettingsMatchTime({Key? key}) : super(key: key);

  @override
  State<OnlineGameSettingsMatchTime> createState() =>
      _OnlineGameSettingsMatchTimeState();
}

class _OnlineGameSettingsMatchTimeState
    extends State<OnlineGameSettingsMatchTime> {
  int _dropdownValue = OnlineGameCreateState().getmatchtime();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        goodTextStyle("Match Time: "),
        DropdownButton<int>(
          value: _dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: AppColors.gamebuttocolor,
          ),
          onChanged: (int? newValue) {
            setState(() {
              _dropdownValue = newValue!;
            });
          },
          items: <int>[30, 60, 90].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child:
                  goodTextStyle("Sec: \t${value.toString()}\t\t\t\t\t\t\t\t"),
              onTap: () => OnlineGameCreateState().setmatchtime(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
