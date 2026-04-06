import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/category_bloc/category_bloc.dart';
import '../../application/category_bloc/category_event.dart';
import '../../application/category_bloc/category_state.dart';
import '../../application/category_games_bloc/category_games_bloc.dart';
import '../../application/category_games_bloc/category_games_event.dart';
import 'package:game_seeker/core/constants/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (state is CategoryError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: AppColors.error),
            ),
          );
        } else if (state is CategoryLoaded) {
          return SizedBox(
            height: 54,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: state.genres.length,
              itemBuilder: (context, index) {
                final genre = state.genres[index];
                final isSelected = state.selectedCategoryId == genre.id;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      context.read<CategoryBloc>().add(SelectCategory(genre.id));
                      context.read<CategoryGamesBloc>().add(
                            LoadGamesByCategory(genre.id.toString()),
                          );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.surfaceLight,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        genre.name,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
