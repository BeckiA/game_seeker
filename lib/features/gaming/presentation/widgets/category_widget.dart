import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/category_bloc/category_bloc.dart';
import '../../application/category_bloc/category_event.dart';
import '../../application/category_bloc/category_state.dart';
import '../../application/category_games_bloc/category_games_bloc.dart';
import '../../application/category_games_bloc/category_games_event.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        } else if (state is CategoryLoaded) {
          return SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.genres.length,
              itemBuilder: (context, index) {
                final genre = state.genres[index];
                final isSelected = state.selectedCategoryId == genre.id;

                return GestureDetector(
                  onTap: () {
                    // 1. Update selection state in CategoryBloc
                    context.read<CategoryBloc>().add(SelectCategory(genre.id));
                    // 2. Trigger the filtered games fetch in the other BLoC
                    context.read<CategoryGamesBloc>().add(
                      LoadGamesByCategory(genre.id.toString()),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      genre.name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: isSelected
                            ? 16
                            : 14, // Selected state requirement
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
