import 'package:equatable/equatable.dart';

class Game extends Equatable {
  final int id;
  final String name;
  final String backgroundImage;
  final double rating;

  const Game({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, name, backgroundImage, rating];
}
