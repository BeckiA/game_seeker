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
import 'package:game_seeker/core/constants/app_colors.dart';

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
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderWidget(),
                
                // Section: Categories
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const CategoryWidget(),

                // Section: Games by Genre
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Games by Genre",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Discover games from your favorite genre",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildCategoryGamesList(),

                // Section: All Games
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                  child: Text(
                    "Trending Games",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                _buildAllGamesList(),
                
                const SizedBox(height: 32),
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
        if (state is CategoryGamesLoading) {
          return const SizedBox(
            height: 260,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        if (state is CategoryGamesLoaded) {
          return SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: state.games.length,
              itemBuilder: (context, index) =>
                  GameCard(game: state.games[index]),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.surfaceLight),
            ),
            child: const Column(
              children: [
                Icon(Icons.gamepad_outlined, color: AppColors.textSecondary, size: 32),
                SizedBox(height: 12),
                Text(
                  "Select a category above to explore games",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAllGamesList() {
    return BlocBuilder<AllGamesBloc, AllGamesState>(
      builder: (context, state) {
        if (state is AllGamesLoading) {
          return const SizedBox(
            height: 260,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        if (state is AllGamesLoaded) {
          return SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
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
