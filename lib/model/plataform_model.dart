class GamePlatform {
  final int id;
  final String name;

  GamePlatform({required this.id, required this.name});

  factory GamePlatform.fromJson(Map<String, dynamic> json) {
    return GamePlatform(
      id: json['platform']['id'],
      name: json['platform']['name'],
    );
  }
}
