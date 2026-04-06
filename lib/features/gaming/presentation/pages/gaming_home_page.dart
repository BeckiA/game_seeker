import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_seeker/features/gaming/application/all_games_bloc/all_games_event.dart';
import 'package:game_seeker/features/gaming/application/all_games_bloc/all_games_state.dart';
import 'package:game_seeker/features/gaming/application/category_games_bloc/category_games_state.dart';
import '../../../../injection_container.dart';
import '../../application/all_games_bloc/all_games_bloc.dart';
import '../../application/category_bloc/category_bloc.dart';
import '../../application/category_bloc/category_event.dart';
import '../../application/category_games_bloc/category_games_bloc.dart';
import '../widgets/header_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/game_card.dart';

class GamingHomePage extends StatelessWidget {
  const GamingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CategoryBloc>()..add(FetchGenres())),
        BlocProvider(create: (_) => sl<AllGamesBloc>()..add(LoadAllGames())),
        BlocProvider(create: (_) => sl<CategoryGamesBloc>()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderWidget(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const CategoryWidget(),

                // Section: Games by Category
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Games by Genre",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildCategoryGamesList(),

                // Section: All Games
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "All Games",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildAllGamesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryGamesList() {
    return BlocBuilder<CategoryGamesBloc, CategoryGamesState>(
      builder: (context, state) {
        if (state is CategoryGamesLoading)
          return const CircularProgressIndicator();
        if (state is CategoryGamesLoaded) {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.games.length,
              itemBuilder: (context, index) =>
                  GameCard(game: state.games[index]),
            ),
          );
        }
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Select a category to see games"),
        );
      },
    );
  }

  Widget _buildAllGamesList() {
    return BlocBuilder<AllGamesBloc, AllGamesState>(
      builder: (context, state) {
        if (state is AllGamesLoading)
          return const Center(child: CircularProgressIndicator());
        if (state is AllGamesLoaded) {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.games.length,
              itemBuilder: (context, index) =>
                  GameCard(game: state.games[index]),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
