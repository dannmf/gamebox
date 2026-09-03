# Gamebox - Contexto do Projeto

## O que e o projeto

Gamebox e uma aplicacao Flutter educacional que funciona como uma biblioteca de jogos. Ela consome a RAWG Video Games Database API para listar, detalhar e buscar jogos, com autenticacao via Firebase Auth.

## Plataformas suportadas

Android, iOS, Linux, macOS, Web, Windows

## Versoes

- Dart SDK: >=2.19.4 <3.0.0
- Flutter: compativel com a versao do SDK acima

## Estrutura de pastas

```
lib/
  controller/
    api/              # GameService - integracao com RAWG API
    auth/             # AuthService - autenticacao Firebase
    errors/           # Widgets de erro
    search/           # Controlador de busca (incompleto)
    build_game_card_controller.dart
  model/
    game_model.dart         # Modelo Game com factory fromJson()
    plataform_model.dart    # Modelo GamePlatform
  view/
    login.dart              # Tela de login/cadastro
    game_list.dart.dart     # Tela principal (nota: nome com .dart duplicado - bug conhecido)
    game_detail.dart        # Tela de detalhes do jogo
  widgets/
    circular_progress.dart
    game_platforms.dart     # Icones de plataformas via switch-case
    grid_view_build.dart
    metacritic_widget.dart
  main.dart
```

## Arquitetura atual

MVC simplificado com StatefulWidget + setState. Sem gerenciador de estado avancado (sem BLoC, Provider, Riverpod ou GetX).

Pontos criticos de debito tecnico:
- Estado gerenciado apenas com setState
- Credenciais de API e Firebase hardcoded no codigo
- Zero cobertura de testes
- Nenhum sistema de injecao de dependencias
- Arquivo com nome incorreto: `game_list.dart.dart`
- search_controller.dart e um placeholder vazio

## Dependencias principais

```yaml
dio: ^5.1.1               # Cliente HTTP
firebase_core: ^3.2.0     # Firebase core
firebase_auth: ^5.1.2     # Autenticacao
cloud_firestore: ^5.1.0   # Firestore (configurado, pouco usado)
font_awesome_flutter       # Icones de plataformas
url_launcher               # Abrir Metacritic no browser
flutter_spinkit            # Loading animado
```

## Servicos externos

### RAWG API
- Base URL: `https://api.rawg.io/api/games`
- Metodos: `getGames()`, `getGameDetails()`, `searchGames()`
- Autenticacao: API Key hardcoded em `controller/api/api.dart`

### Firebase
- Projeto: `gamebox-2d86f`
- Servicos: Auth (email/senha), Firestore (pouco utilizado)
- Credenciais hardcoded em `controller/auth/auth_service.dart`

## Convencoes de codigo

- Classes: PascalCase
- Metodos/variaveis: camelCase
- Privados: prefixo `_` (ex: `_auth`, `_gameService`)
- Factory methods para desserializacao: `Game.fromJson()`, `GamePlatform.fromJson()`
- FutureBuilder para operacoes assincronas
- LayoutBuilder para responsividade mobile/web

## Tema

- Tema dark
- Cor primaria: deep purple
- Cor de destaque: dourado (ARGB 235, 210, 130)

## Testes

Nenhum teste implementado. `flutter_test` esta em dev_dependencies mas sem arquivos de teste.

## Proximas refatoracoes planejadas

O branch atual (`feat-create-context-to-refactor`) foi criado para estruturar contexto antes de iniciar refatoracoes. As areas prioritarias de melhoria sao:
1. Introducao de gerenciamento de estado (BLoC ou Provider)
2. Remover credenciais do codigo e usar variaveis de ambiente
3. Adicionar cobertura de testes
4. Corrigir nome do arquivo `game_list.dart.dart`
5. Implementar injecao de dependencias
6. Completar o search_controller.dart

## Comandos uteis

```bash
flutter pub get           # Instalar dependencias
flutter analyze           # Analise de linting
flutter test              # Executar testes
flutter run               # Rodar a aplicacao
flutter build apk         # Build Android
```
