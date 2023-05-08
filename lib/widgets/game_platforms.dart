import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamebox/model/plataform_model.dart';

class GamePlatformWidget extends StatelessWidget {
  final GamePlatform platform;

  const GamePlatformWidget({Key? key, required this.platform})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData platformIcon;
    String platformName;
    switch (platform.name) {
      case "Xbox 360":
        platformIcon = FontAwesomeIcons.xbox;
        platformName = "Xbox 360";
        break;
      case "PlayStation 3":
        platformIcon = FontAwesomeIcons.playstation;
        platformName = "PS3";
        break;
      case "PlayStation 4":
        platformIcon = FontAwesomeIcons.playstation;
        platformName = "PS4";
        break;
      case "Xbox One":
        platformIcon = FontAwesomeIcons.xbox;
        platformName = "Xbox One";
        break;
      case "PC":
        platformIcon = FontAwesomeIcons.computer;
        platformName = "PC";
        break;
      case "Nintendo Switch":
        platformIcon = FontAwesomeIcons.gamepad;
        platformName = "Nintendo Switch";
        break;
      case "PlayStation 5":
        platformIcon = FontAwesomeIcons.playstation;
        platformName = "PS5";
        break;
      case "Xbox Series S/X":
        platformIcon = FontAwesomeIcons.xbox;
        platformName = "Xbox Series S/X";
        break;
      case "iOS":
        platformIcon = FontAwesomeIcons.apple;
        platformName = "iOS";
        break;
      case "Android":
        platformIcon = FontAwesomeIcons.android;
        platformName = "Android";
        break;
      case "Linux":
        platformIcon = FontAwesomeIcons.linux;
        platformName = "Linux";
        break;
      case "macOS":
        platformIcon = FontAwesomeIcons.computer;
        platformName = "MacOS";
        break;
      // adicione mais cases para outras plataformas
      default:
        platformIcon =
            Icons.devices; // ícone padrão para plataforma desconhecida
        platformName = platform.name;
        break;
    }

    return Container(
      margin: EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(platformIcon),
          ),
          const SizedBox(
            width: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(platformName),
          ),
        ],
      ),
    );
  }
}

// class GameWidget extends StatelessWidget {
//   final Game game;

//   const GameWidget({Key? key, required this.game}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(game.name),
//         Text(game.description),
//         Row(
//           children: [
//             for (var platform in game.platforms)
//               GamePlatformWidget(platform: platform),
//           ],
//         ),
//       ],
//     );
//   }
// }
