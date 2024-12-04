import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wine_event.dart';
import 'wine_state.dart';
import 'wine_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class WineBloc extends Bloc<WineEvent, WineState> {
  WineBloc() : super(WineLoading()) {
    // Înregistrează handler-ul pentru evenimentul LoadWines
    on<LoadWines>((event, emit) async {
      emit(WineLoading());
      try {
        final data = await rootBundle.loadString('assets/v3.json');
        final jsonResult = json.decode(data);
        final wines = (jsonResult['carousel'] as List)
            .map((wineJson) => Wine.fromJson(wineJson))
            .toList();
        emit(WineLoaded(wines));
      } catch (_) {
        emit(WineError());
      }
    });
  }
}
