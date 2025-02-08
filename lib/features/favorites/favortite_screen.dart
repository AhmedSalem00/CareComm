import 'package:carecomm/features/product/cubit/cubit.dart';
import 'package:carecomm/features/product/cubit/state.dart';
import 'package:carecomm/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            List<Product> favorites = state.favorites;

            if (favorites.isEmpty) {
              return Center(child: Text('No favorites yet'));
            }

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(favorites[index].image!),
                  title: Text(favorites[index].title!),
                  subtitle: Text('\$${favorites[index].price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      context.read<FavoritesCubit>().removeFavorite(favorites[index].id!);
                    },
                  ),
                );
              },
            );
          } else if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
