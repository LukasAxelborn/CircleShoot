import 'package:flutter/material.dart';

import '../../../../settings/app_settings/app_colors.dart';
import '../../../../widgets/good_text_style.dart';
import '../../online_game_create_state/online_game_create_state.dart';

class OnlineGameSettingsGamemodels extends StatefulWidget {
  const OnlineGameSettingsGamemodels({Key? key}) : super(key: key);

  @override
  State<OnlineGameSettingsGamemodels> createState() =>
      OnlineGameSettingsGamemodelsState();
}

class OnlineGameSettingsGamemodelsState
    extends State<OnlineGameSettingsGamemodels> {
  Color getColor(Set<MaterialState> states) {
    return AppColors.primary;
  }

  int _dropdownLives = OnlineGameCreateState().getlaststandingscore();
  bool laststanding = OnlineGameCreateState().getlaststandingbool();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        goodTextStyle("Last Standing"),
        DropdownButton<int>(
          value: _dropdownLives,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: AppColors.gamebuttocolor,
          ),
          onChanged: (int? newValue) {
            setState(() {
              _dropdownLives = newValue!;
            });
          },
          items: <int>[10, 20, 30].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: goodTextStyle("Lives: ${value.toString()}"),
              onTap: () => OnlineGameCreateState().setlaststandingscore(value),
            );
          }).toList(),
        ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: laststanding,
          onChanged: (bool? value) {
            setState(() {
              laststanding = value!;
              OnlineGameCreateState().setlaststandingbool(laststanding);
            });
          },
        ),
      ],
    );
  }
}
