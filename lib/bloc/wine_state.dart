import 'wine_model.dart';

abstract class WineState {}

class WineLoading extends WineState {}

class WineLoaded extends WineState {
  final List<Wine> wines;
  WineLoaded(this.wines);
}

class WineError extends WineState {}
