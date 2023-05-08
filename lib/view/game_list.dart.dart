import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamebox/controller/api/api.dart';
import 'package:gamebox/controller/auth/auth_service.dart';
import 'package:gamebox/controller/errors/build_error_indicator.dart';
import 'package:gamebox/model/game_model.dart';
import 'package:gamebox/view/login.dart';
import 'package:gamebox/widgets/circular_progress.dart';
import 'package:gamebox/widgets/grid_view_build.dart';

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
}

AuthService _auth = AuthService();

class _GameListState extends State<GameList> {
  Timer? _debounce;
  bool showClose = false;
  bool _isSearch = false;
  final GameService _gameService = GameService();
  final TextEditingController _searchController = TextEditingController();
  List<Game> _searchResults = [];
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    setState(() {
      _gamesFuture = _gameService.getGames();
    });
  }

  late Future<List<Game>> _gamesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _isSearch
            ? TextField(
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    _search();
                    setState(() {
                      showClose = value.isNotEmpty;
                    });
                  });
                },
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Games',
                ),
                onSubmitted: (_) => _search(),
              )
            : const Text('Biblioteca'),
        actions: [
          PopupMenuButton(
            position: PopupMenuPosition.over,
            tooltip: 'Usuário',
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                _auth.signOut(context);
              }
            },
            icon: Icon(Icons.account_circle),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isSearch = !_isSearch;
                if (!_isSearch) {
                  _searchController.clear();
                }
              });
            },
            icon:
                _isSearch ? const Icon(Icons.close) : const Icon(Icons.search),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileBody();
        } else {
          return _buildWebBody();
        }
      }),
    );
  }

  Widget _buildMobileBody() {
    return _buildBody();
  }

  Widget _buildWebBody() {
    return Center(
      child: Container(
        width: 600,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Game>>(
      future: _gamesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingIndicator();
        } else if (snapshot.hasError) {
          return buildErrorIndicator(snapshot.error);
        } else {
          final games = snapshot.data!;
          return _searchResults.isEmpty
              ? buildGameGrid(games)
              : buildGameGrid(_searchResults);
        }
      },
    );
  }

  void _search() async {
    if (_searchController.text.isEmpty) {
      final games = await _gameService.getGames();
      setState(() {
        _searchResults = games;
      });
    } else {
      final games = await _gameService.searchGames(_searchController.text);
      setState(() {
        _searchResults = games;
      });
    }
  }
}
