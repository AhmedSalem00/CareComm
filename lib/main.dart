import 'package:carecomm/features/navbar/navbar_screen.dart';
import 'package:carecomm/features/product/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ProductCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        ));
  }
}


