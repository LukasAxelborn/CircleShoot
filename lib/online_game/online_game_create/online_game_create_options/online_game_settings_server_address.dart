import 'package:flutter/material.dart';

import '../../../widgets/good_text_style.dart';
import '../online_game_create_state/online_game_create_state.dart';

class OnlineGameSettingServerAddress extends StatefulWidget {
  const OnlineGameSettingServerAddress({Key? key}) : super(key: key);

  @override
  State<OnlineGameSettingServerAddress> createState() =>
      _OnlineGameSettingServerAddressState();
}

class _OnlineGameSettingServerAddressState
    extends State<OnlineGameSettingServerAddress> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OnlineGameCreateState().setserveraddress("");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        goodTextStyle("Create An Server Address"),
        Center(
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: "Server Address",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () => {
                  _textController.clear(),
                  OnlineGameCreateState().setserveraddress(""),
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            onChanged: (text) => OnlineGameCreateState().setserveraddress(text),
          ),
        ),
      ],
    );
  }
}
