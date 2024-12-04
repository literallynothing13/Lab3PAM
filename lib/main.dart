import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/wine_bloc.dart';
import 'bloc/wine_event.dart';
import 'bloc/wine_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wine App',
      home: BlocProvider(
        create: (context) => WineBloc()..add(LoadWines()),
        child: const WineScreen(),
      ),
    );
  }
}

class WineScreen extends StatelessWidget {
  const WineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wine List')),
      body: BlocBuilder<WineBloc, WineState>(
        builder: (context, state) {
          if (state is WineLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WineLoaded) {
            return ListView.builder(
              itemCount: state.wines.length,
              itemBuilder: (context, index) {
                final wine = state.wines[index];
                return ListTile(
                  leading: Image.network(wine.image),
                  title: Text(wine.name),
                  subtitle: Text('${wine.country}, ${wine.city}'),
                  trailing: Text('\$${wine.priceUsd}'),
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load wines'));
          }
        },
      ),
    );
  }
}
