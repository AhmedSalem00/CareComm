import 'dart:convert';
import 'package:carecomm/features/product/cubit/cubit.dart';
import 'package:carecomm/features/product/cubit/state.dart';
import 'package:carecomm/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Manually create a mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductCubit cubit;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    SharedPreferences.setMockInitialValues({}); // Important for tests
    cubit = ProductCubit();
  });

  tearDown(() {
    cubit.close();
  });

  group('loadFavorites', () {
    test('loads favorites successfully from SharedPreferences', () async {
      final product = Product(id: 1, title: 'Test Product', price: 10.0);
      final favoritesJson = jsonEncode([product.toJson()]);

      when(mockSharedPreferences.getString('favorites')).thenReturn(favoritesJson);
      when(SharedPreferences.getInstance()).thenAnswer((_) async => mockSharedPreferences);

      await cubit.loadFavorites();

      expect(cubit.state, isA<FavoritesLoaded>());
      expect((cubit.state as FavoritesLoaded).favorites.length, 1);
      expect((cubit.state as FavoritesLoaded).favorites[0].id, 1);
    });

    test('loads empty favorites when no data in SharedPreferences', () async {
      when(mockSharedPreferences.getString('favorites')).thenReturn(null);
      when(SharedPreferences.getInstance()).thenAnswer((_) async => mockSharedPreferences);

      await cubit.loadFavorites();

      expect(cubit.state, isA<FavoritesLoaded>());
      expect((cubit.state as FavoritesLoaded).favorites.isEmpty, true);
    });

    test('emits FavoritesError when loading from SharedPreferences fails', () async {
      when(mockSharedPreferences.getString('favorites')).thenThrow(Exception('Failed to load'));
      when(SharedPreferences.getInstance()).thenAnswer((_) async => mockSharedPreferences);

      await cubit.loadFavorites();

      expect(cubit.state, isA<FavoritesError>());
      expect((cubit.state as FavoritesError).message, 'Failed to load favorites: Exception: Failed to load');
    });
  });

  group('addFavorite', () {
    test('adds a product to favorites and saves to SharedPreferences', () async {
      final product = Product(id: 1, title: 'Test Product', price: 10.0);
      when(SharedPreferences.getInstance()).thenAnswer((_) async => mockSharedPreferences);
      when(mockSharedPreferences.setString('favorites', any??'')).thenAnswer((_) async => true); // Mock successful save

      await cubit.addFavorite(product);

      expect(cubit.state, isA<FavoritesLoaded>());
      expect((cubit.state as FavoritesLoaded).favorites.length, 1);
      expect((cubit.state as FavoritesLoaded).favorites[0].id, 1);
      verify(mockSharedPreferences.setString('favorites', any??'')).called(1); // Verify save was called
    });

    test('emits FavoritesError when adding to favorites fails', () async {
      final product = Product(id: 1, title: 'Test Product', price: 10.0);
      when(SharedPreferences.getInstance()).thenAnswer((_) async => mockSharedPreferences);
      when(mockSharedPreferences.setString('favorites', any??'')).thenThrow(Exception('Failed to save'));

      await cubit.addFavorite(product);

      expect(cubit.state, isA<FavoritesError>());
      expect((cubit.state as FavoritesError).message, 'Failed to add product to favorites: Exception: Failed to save');
    });
  });

  group('removeFavorite', () {
    test('removes a product from favorites and saves to SharedPreferences', () async {
      final product1 = Product(id: 1, title: 'Test Product 1', price: 10.0);
      final product2 = Product(id: 2, title: 'Test Product 2', price: 20.0);
      final favoritesJson = jsonEncode([product1.toJson(), product2.toJson()]);

      when(mockSharedPreferences.getString('favorites')).thenReturn(favoritesJson);
      when(SharedPreferences.getInstance()).thenAnswer((_) async => mockSharedPreferences);
      when(mockSharedPreferences.setString('favorites', any??'')).thenAnswer((_) async => true);

      await cubit.loadFavorites(); // Load initial favorites
      await cubit.removeFavorite(1);

      expect(cubit.state, isA<FavoritesLoaded>());
      expect((cubit.state as FavoritesLoaded).favorites.length, 1);
      expect((cubit.state as FavoritesLoaded).favorites[0].id, 2);
      verify(mockSharedPreferences.setString('favorites', any??'')).called(1);
    });

    test('emits FavoritesError when removing from favorites fails', () async {
      final product = Product(id: 1, title: 'Test Product', price: 10.0);
      when(SharedPreferences.getInstance()).thenAnswer((_) async => mockSharedPreferences);
      when(mockSharedPreferences.setString('favorites', any??'')).thenThrow(Exception('Failed to save'));

      await cubit.removeFavorite(product.id!);

      expect(cubit.state, isA<FavoritesError>());
      expect((cubit.state as FavoritesError).message, 'Failed to remove product from favorites: Exception: Failed to save');
    });
  });
}
