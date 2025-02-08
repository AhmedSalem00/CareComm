# CareComm Flutter Project

## Description

This is a Flutter project for the **CareComm** app, which features a favorites system where users can add and remove products from their favorites list. It uses the **Flutter BLoC** for state management and **SharedPreferences** for persisting the favorite products.

The app is built with the following main components:

- **ProductCubit**: Manages the state of the favorite products.
- **FavoritesScreen**: Displays the list of favorite products.

This project demonstrates state management with Flutter using BLoC and persistence with SharedPreferences.

## Features

- Add and remove products from favorites.
- Persist favorites data using SharedPreferences.
- State management with BLoC for a reactive UI.


### Prerequisites

To run this project locally, you'll need:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
- A code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
- An Android/iOS device or emulator to run the app.

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/AhmedSalem00/carecomm.git

   Directory Structure
Here’s a breakdown of the key parts of the project:

## lib/core: Contains helper functions and API services.
## lib/features/product: Contains the BLoC cubit for managing product state, including ProductCubit and ProductState.
## lib/features/product_details: Contains the screen where product details are displayed.
## lib/features/product/cubit/state.dart: Defines the various states related to the product (e.g., loading, loaded, error).
## lib/features/product/data/models/product_model.dart: Defines the model for the Product.
BLoC Overview
The app uses the BLoC pattern to manage the state.

ProductCubit
The ProductCubit is responsible for loading, adding, and removing products from the favorites list. It communicates with SharedPreferences to persist the data.

ProductState
The states that ProductState can emit include:

ProductInitial: The initial state before data is loaded.
ProductLoaded: The state when the data has been successfully loaded.
ProductError: The state in which an error occurs while loading or modifying favorites.
ProductScreen
This screen uses BlocBuilder to listen for changes in the ProductCubit state. It updates the UI to display the list of favorite products or an error message.

## Dependencies
Here are the main dependencies used in this project:

flutter_bloc: State management with the BLoC pattern.
shared_preferences: Used to save and load favorite products.
flutter: The core framework for building the app.


## Responsiveness
This application is fully responsive and provides an optimal experience across various devices, including:
Mobile: Seamlessly adapts to smaller screen sizes for easy navigation and usability.
Tablet: Provides a great layout and user interface on medium-sized screens.
Web: Offers a consistent and user-friendly experience on desktop and larger screens.
