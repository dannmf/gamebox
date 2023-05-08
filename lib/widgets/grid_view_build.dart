import 'package:flutter/material.dart';
import 'package:gamebox/controller/build_game_card_controller.dart';
import 'package:gamebox/model/game_model.dart';

buildGameGrid(List<Game> games) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.70,
    ),
    itemCount: games.length,
    itemBuilder: (context, index) {
      final game = games[index];
      return buildGameCard(game, context);
    },
  );
}
