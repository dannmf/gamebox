import 'package:dio/dio.dart';
import 'package:gamebox/model/game_model.dart';

class GameService {
  final String _apiKey = 'ec1d527daa184661b288698f065ca22d';

  Future<List<Game>> getGames() async {
    final response = await Dio().get(
      'https://api.rawg.io/api/games',
      queryParameters: {'key': _apiKey},
    );
    final data = response.data['results'];
    return List<Game>.from(data.map((json) => Game.fromJson(json)));
  }

  Future<Game> getGameDetails(int gameId) async {
    final response = await Dio().get(
      'https://api.rawg.io/api/games/$gameId',
      queryParameters: {'key': _apiKey},
    );
    final data = response.data;
    return Game.fromJson(data);
  }

  Future<List<Game>> searchGames(String searchQuery) async {
    final games = await getGames();
    return games
        .where((game) =>
            game.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
