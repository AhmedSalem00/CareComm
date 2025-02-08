
import 'package:carecomm/core/helper/responsive_helper.dart';
import 'package:carecomm/core/networking/api_service.dart';
import 'package:carecomm/features/product/cubit/cubit.dart';
import 'package:carecomm/features/product%20details/product_details_screen.dart';
import 'package:carecomm/features/product/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/models/product_model.dart';


class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesCubit>().loadFavorites();
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List<Product> products = snapshot.data ?? [];
          int crossAxisCount = 2;
          if (ResponsiveHelper.isTab(context)) {
            crossAxisCount = 3;
          } else if (ResponsiveHelper.isDesktop(context)) {
            crossAxisCount = 4;
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];

              final favoritesState = context.watch<FavoritesCubit>().state;
              bool isFavorite = false;

              if (favoritesState is FavoritesLoaded) {
                isFavorite = favoritesState.favorites.contains(product);
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.all(8),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.network(
                              product.image!,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    product.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "\$${product.price}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 0,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              context.read<FavoritesCubit>().addFavorite(product);
                            },
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
