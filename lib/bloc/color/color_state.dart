part of 'color_bloc.dart';

class ColorState extends Equatable {
 final Color colorPrimary;
 final Color colorSecondary;
 final Color colorDark;
 final Color inverseColor;
  
  ColorState({
    required this.colorPrimary,
    required this.colorSecondary,
    required this.colorDark,
    required this.inverseColor
  });

  factory ColorState.initial(){
    return ColorState(
        colorPrimary: Color.fromRGBO(24, 140, 65, 1),
        colorSecondary: Colors.white,
        colorDark: Color.fromRGBO(14, 80, 65, 1),
        inverseColor: Color.fromRGBO(31, 41, 43, 1.0)
    );
  }

  ColorState copyWith({Color? colorPrimary, Color? colorSecondary, Color? colorDark, Color? inverseColor}){
    return ColorState(
        colorPrimary: colorPrimary ?? this.colorPrimary,
        colorSecondary: colorSecondary ?? this.colorSecondary,
        colorDark: colorDark ?? this.colorDark,
        inverseColor: inverseColor ?? this.inverseColor
    );
  }

  @override
  String toString() {
    return 'ColorState{color: $colorPrimary colorSecondary: $colorSecondary}';
  }

  @override
  List<Object?> get props => [colorPrimary, colorSecondary, colorDark, inverseColor];
}