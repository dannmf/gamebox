// ignore_for_file: deprecated_member_use, avoid_print, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:gamebox/model/game_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MetacriticScore extends StatelessWidget {
  final int score;
  final Game game;
  MetacriticScore({required this.score, required this.game});

  @override
  Widget build(BuildContext context) {
    Color scoreColor = Colors.white;
    if (score >= 90) {
      scoreColor = Colors.green;
    } else if (score >= 75) {
      scoreColor = Colors.yellow;
    } else if (score > 0) {
      scoreColor = Colors.red;
    }
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Metacritic Score: ',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '$score',
              style: TextStyle(fontSize: 20, color: scoreColor),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white)),
              child: const Text(
                'Veja no Metacritic',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                String metacriticUrl =
                    'https://www.metacritic.com/game/pc/${game.name.replaceAll(' ', '-').toLowerCase()}';
                try {
                  launch(metacriticUrl,
                      forceSafariVC: false, universalLinksOnly: true);
                } catch (e) {
                  print('Error launching URL: $e');
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
