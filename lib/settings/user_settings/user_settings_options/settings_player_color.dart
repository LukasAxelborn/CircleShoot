import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:game/settings/app_settings/app_colors.dart';
import 'package:game/settings/user_settings/user_settings_option_state/user_settings_state.dart';
import 'package:game/widgets/customs_options_row.dart';

class SettingsPlayerColor extends StatefulWidget {
  const SettingsPlayerColor({Key? key}) : super(key: key);

  @override
  State<SettingsPlayerColor> createState() => _SettingsPlayerColorState();
}

class _SettingsPlayerColorState extends State<SettingsPlayerColor> {
  Color buttonColor = UserSettingsState().getPlayerColor();
  @override
  void initState() {
    super.initState();
    buttonColor = UserSettingsState().getPlayerColor();
  }

  @override
  Widget build(BuildContext context) {
    //buttonColor = UserSettingsState().getPlayerColor();
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ColorPickerScreen()),
        );
      },
      color: AppColors.primary,
      child: const Text(
        'Change Player Color',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  State<ColorPickerScreen> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerScreen> {
  // Color for the picker shown in Card on the screen.
  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
    screenPickerColor = UserSettingsState().getPlayerColor(); // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Player Color'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        children: <Widget>[
          // Show the selected color.
          CustomsRow(
            widget: ListTile(
              title: const Text('Select color below to change this color'),
              //subtitle:
              //    Text('${ColorTools.materialNameAndCode(screenPickerColor)} '
              //        'aka ${ColorTools.nameThatColor(screenPickerColor)}'),
              trailing: ColorIndicator(
                width: 44,
                height: 44,
                borderRadius: 22,
                color: screenPickerColor,
              ),
            ),
          ),
          CustomsRow(
            widget: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Card(
                  elevation: 2,
                  child: ColorPicker(
                    // Use the screenPickerColor as start color.
                    color: screenPickerColor,
                    // Update the screenPickerColor using the callback.
                    onColorChanged: (Color color) => setState(() => {
                          screenPickerColor = color,
                          UserSettingsState().setPlayerColor(
                            screenPickerColor.red,
                            screenPickerColor.green,
                            screenPickerColor.blue,
                            screenPickerColor.opacity,
                          )
                        }),
                    width: 44,
                    height: 44,
                    borderRadius: 22,
                    heading: Text(
                      'Select color',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    subheading: Text(
                      'Select color shade',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
