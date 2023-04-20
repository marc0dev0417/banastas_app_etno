part of 'color_bloc.dart';

class ColorState extends Equatable {
 final Color colorPrimary;
 final Color colorSecondary;
  
  ColorState({
    required this.colorPrimary,
    required this.colorSecondary
  });

  factory ColorState.initial(){
    return ColorState(
        colorPrimary: Colors.white,
        colorSecondary: Colors.white
    );
  }

  ColorState copyWith({Color? colorPrimary, Color? colorSecondary}){
    return ColorState(
        colorPrimary: colorPrimary ?? this.colorPrimary,
        colorSecondary: colorSecondary ?? this.colorSecondary
    );
  }

  @override
  String toString() {
    return 'ColorState{color: $colorPrimary colorSecondary: $colorSecondary}';
  }

  @override
  List<Object?> get props => [colorPrimary, colorSecondary];
}