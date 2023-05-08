import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gamebox/controller/api/api.dart';
import 'package:gamebox/model/game_model.dart';
import 'package:gamebox/widgets/game_platforms.dart';
import 'package:gamebox/widgets/metacritic_widget.dart';

class GameDetails extends StatefulWidget {
  final int gameId;

  GameDetails({required this.gameId});

  @override
  _GameDetailsState createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  late Future<Game> _futureGame;

  @override
  void initState() {
    super.initState();
    _futureGame = GameService().getGameDetails(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Game>(
        future: _futureGame,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Failed to fetch game details.'));
          }
          final game = snapshot.requireData;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.network(
                      game.backgroundImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        game.name,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          children:
                              game.description.split('\n').map((paragraph) {
                            return TextSpan(
                              text: '$paragraph\n',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            );
                          }).toList(),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 600) {
                            return Row(
                              children: game.platforms
                                  .map((platform) =>
                                      GamePlatformWidget(platform: platform))
                                  .toList(),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: game.platforms
                                    .map(
                                      (platform) => GamePlatformWidget(
                                          platform: platform),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                        },
                      ),
                      if (game.metacritic > 0) ...[
                        const SizedBox(height: 16),
                        MetacriticScore(score: game.metacritic, game: game)
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
