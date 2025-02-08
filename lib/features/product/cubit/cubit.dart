// import 'dart:convert';
// import 'package:carecomm/features/product/data/models/product_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class FavoritesCubit extends Cubit<List<Product>> {
//   FavoritesCubit() : super([]);
//
//   // Load favorite products from SharedPreferences
//   Future<void> loadFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? favoritesJson = prefs.getString('favorites');
//
//     if (favoritesJson != null) {
//       List<dynamic> favoritesList = jsonDecode(favoritesJson);
//       List<Product> favorites = favoritesList
//           .map((productJson) => Product.fromJson(productJson))
//           .toList();
//       emit(favorites);
//     }
//   }
//
//   // Save favorite products to SharedPreferences
//   Future<void> _saveFavorites(List<Product> favorites) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String favoritesJson = jsonEncode(favorites.map((product) => product.toJson()).toList());
//     await prefs.setString('favorites', favoritesJson);
//   }
//
//   // Add a product to favorites
//   Future<void> addFavorite(Product product) async {
//     List<Product> updatedFavorites = List.from(state);
//     updatedFavorites.add(product);
//     emit(updatedFavorites);
//     await _saveFavorites(updatedFavorites);
//   }
//
//   // Remove a product from favorites
//   Future<void> removeFavorite(int productId) async {
//     List<Product> updatedFavorites = List.from(state);
//     updatedFavorites.removeWhere((product) => product.id == productId);
//     emit(updatedFavorites);
//     await _saveFavorites(updatedFavorites);
//   }
//   bool isDark = false;
//   void changeAppModel(){
//     isDark =!isDark;
//     emit(isDark as List<Product>);
//   }
// }
//
import 'dart:convert';
import 'package:carecomm/features/product/cubit/state.dart';
import 'package:carecomm/features/product/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  // Load favorite products from SharedPreferences
  Future<void> loadFavorites() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? favoritesJson = prefs.getString('favorites');

      if (favoritesJson != null) {
        List<dynamic> favoritesList = jsonDecode(favoritesJson);
        List<Product> favorites = favoritesList
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        emit(FavoritesLoaded(favorites));
      } else {
        emit(FavoritesLoaded([])); // In case there are no favorites saved
      }
    } catch (e) {
      emit(FavoritesError('Failed to load favorites: ${e.toString()}'));
    }
  }

  // Save favorite products to SharedPreferences
  Future<void> _saveFavorites(List<Product> favorites) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favoritesJson = jsonEncode(favorites.map((product) => product.toJson()).toList());
      await prefs.setString('favorites', favoritesJson);
    } catch (e) {
      emit(FavoritesError('Failed to save favorites: ${e.toString()}'));
    }
  }

  // Add a product to favorites
  Future<void> addFavorite(Product product) async {
    try {
      List<Product> updatedFavorites = List.from(state is FavoritesLoaded ? (state as FavoritesLoaded).favorites : []);
      updatedFavorites.add(product);
      emit(FavoritesLoaded(updatedFavorites));
      await _saveFavorites(updatedFavorites);
    } catch (e) {
      emit(FavoritesError('Failed to add product to favorites: ${e.toString()}'));
    }
  }

  // Remove a product from favorites
  Future<void> removeFavorite(int productId) async {
    try {
      List<Product> updatedFavorites = List.from(state is FavoritesLoaded ? (state as FavoritesLoaded).favorites : []);
      updatedFavorites.removeWhere((product) => product.id == productId);
      emit(FavoritesLoaded(updatedFavorites));
      await _saveFavorites(updatedFavorites);
    } catch (e) {
      emit(FavoritesError('Failed to remove product from favorites: ${e.toString()}'));
    }
  }

  bool isDark = false;

  // Change app theme
  void changeAppModel() {
    isDark = !isDark;
    emit(AppThemeChanged(isDark));
  }
}

