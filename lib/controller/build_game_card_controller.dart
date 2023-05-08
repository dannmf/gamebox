import 'package:flutter/material.dart';
import 'package:gamebox/model/game_model.dart';
import 'package:gamebox/view/game_detail.dart';

buildGameCard(Game game, context) {
  return GestureDetector(
    onTap: () async {
      final details = await Navigator.push<Game>(
        context,
        MaterialPageRoute(
          builder: (context) => GameDetails(gameId: game.id),
        ),
      );
      if (details != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${details.name} opened.'),
          ),
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: 200,
        height: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    game.backgroundImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    game.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
