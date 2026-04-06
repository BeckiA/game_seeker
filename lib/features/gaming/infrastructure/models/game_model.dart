import '../../domain/entities/game.dart';

class GameModel extends Game {
  const GameModel({
    required super.id,
    required super.name,
    required super.backgroundImage,
    required super.rating,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      backgroundImage: json['background_image'] ?? '',
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
