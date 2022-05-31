import 'package:flutter/material.dart';

import '../../../../settings/app_settings/app_colors.dart';
import '../../../../widgets/good_text_style.dart';
import '../../online_game_create_state/online_game_create_state.dart';

class OnlineGameSettingsGamemodeFfa extends StatefulWidget {
  const OnlineGameSettingsGamemodeFfa({Key? key}) : super(key: key);

  @override
  State<OnlineGameSettingsGamemodeFfa> createState() =>
      OnlineGameSettingsGamemodeFfaState();
}

class OnlineGameSettingsGamemodeFfaState
    extends State<OnlineGameSettingsGamemodeFfa> {
  Color getColor(Set<MaterialState> states) {
    return AppColors.primary;
  }

  int _dropdownScore = OnlineGameCreateState().getfreeforallscore();
  bool freeforall = OnlineGameCreateState().getfreeforallbool();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        goodTextStyle("Free For All"),
        DropdownButton<int>(
          value: _dropdownScore,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: AppColors.gamebuttocolor,
          ),
          onChanged: (int? newValue) {
            setState(() {
              _dropdownScore = newValue!;
            });
          },
          items: <int>[10, 20, 30].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: goodTextStyle("Score: ${value.toString()}"),
              onTap: () => OnlineGameCreateState().setfreeforallscore(value),
            );
          }).toList(),
        ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: freeforall,
          onChanged: (bool? value) {
            setState(() {
              freeforall = value!;
              OnlineGameCreateState().setfreeforallbool(freeforall);
            });
          },
        ),
      ],
    );
  }
}
