import 'package:dio/dio.dart';
import '../models/game_model.dart';
import '../models/genre_model.dart';

abstract class IGamingRemoteDataSource {
  Future<List<GenreModel>> getGenres();
  Future<List<GameModel>> getGames(String? genreId);
}

class GamingRemoteDataSourceImpl implements IGamingRemoteDataSource {
  final Dio client;
  final String apiKey;
  final String baseUrl;

  GamingRemoteDataSourceImpl({
    required this.client,
    required this.apiKey,
    required this.baseUrl,
  });

  @override
  Future<List<GenreModel>> getGenres() async {
    final response = await client.get(
      '$baseUrl/genres',
      queryParameters: {'key': apiKey},
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((json) => GenreModel.fromJson(json)).toList();
    } else {
      throw Exception(); // In a real app, use a custom ServerException
    }
  }

  @override
  Future<List<GameModel>> getGames(String? genreId) async {
    final Map<String, dynamic> queryParams = {'key': apiKey};
    if (genreId != null) queryParams['genres'] = genreId;

    final response = await client.get(
      '$baseUrl/games',
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((json) => GameModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
