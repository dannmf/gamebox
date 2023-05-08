import 'package:gamebox/model/plataform_model.dart';

class Game {
  final int id;
  final String name;
  final String backgroundImageUrl;
  final String description;
  final int metacritic;
  final List<GamePlatform> platforms;

  Game(
      {required this.id,
      required this.name,
      required this.backgroundImageUrl,
      required this.description,
      required this.metacritic,
      required this.platforms});

  factory Game.fromJson(Map<String, dynamic> json) {
    List<GamePlatform> platforms = [];
    for (var platformJson in json['platforms']) {
      platforms.add(GamePlatform.fromJson(platformJson));
    }
    return Game(
      id: json['id'],
      name: json['name'],
      backgroundImageUrl: json['background_image'],
      description: json['description_raw'] ?? '',
      metacritic: json['metacritic'] ?? 0,
      platforms: platforms,
    );
  }
}
