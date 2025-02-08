import 'package:carecomm/features/product/data/models/product_model.dart';

abstract class ProductState {}

class FavoritesInitial extends ProductState {}

class FavoritesLoaded extends ProductState {
  final List<Product> favorites;

  FavoritesLoaded(this.favorites);
}

class FavoritesError extends ProductState {
  final String message;

  FavoritesError(this.message);
}


