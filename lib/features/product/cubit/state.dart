import 'package:carecomm/features/product/data/models/product_model.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Product> favorites;

  FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}

class AppThemeChanged extends FavoritesState {
  final bool isDark;

  AppThemeChanged(this.isDark);
}
