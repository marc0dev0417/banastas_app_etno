part of 'color_bloc.dart';

abstract class ColorEvent extends Equatable {
  const ColorEvent();
}

class AddColors extends ColorEvent {

  final Color colorPrimary;
  final Color colorSecondary;

  AddColors({required this.colorPrimary, required this.colorSecondary});

  @override
  List<Object?> get props => [colorPrimary, colorSecondary];
}
