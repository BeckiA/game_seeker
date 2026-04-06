import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int id;
  final String name;
  final String imageBackground;

  const Genre({
    required this.id,
    required this.name,
    required this.imageBackground,
  });

  @override
  List<Object?> get props => [id, name, imageBackground];
}
