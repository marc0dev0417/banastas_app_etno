part of 'widget_section_bloc.dart';

class WidgetSectionState extends Equatable {
  final String sectionNameOne;
  final String sectionNameTwo;
  final String sectionNameThree;
  final String sectionNameFour;

  WidgetSectionState({
    required this.sectionNameOne,
    required this.sectionNameTwo,
    required this.sectionNameThree,
    required this.sectionNameFour
  });

  factory WidgetSectionState.initial() {
    return WidgetSectionState(
        sectionNameOne: 'Noticias',
        sectionNameTwo: 'Eventos',
        sectionNameThree: 'Turismo',
        sectionNameFour: 'Servicios'
    );
  }

  WidgetSectionState copyWith({ String? sectionNameOne, String? sectionNameTwo, String? sectionNameThree, String? sectionNameFour }){
    return WidgetSectionState(
        sectionNameOne: sectionNameOne ?? this.sectionNameOne,
        sectionNameTwo: sectionNameTwo ?? this.sectionNameTwo,
        sectionNameThree: sectionNameThree ?? this.sectionNameThree,
        sectionNameFour: sectionNameFour ?? this.sectionNameFour
    );
  }

  @override
  String toString() {
    return 'WidgetSectionState{listWidgetButton: $sectionNameOne}';
  }

  @override
  List<Object?> get props => [sectionNameOne, sectionNameTwo, sectionNameThree, sectionNameFour];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return {
      'section_one': sectionNameOne,
      'section_two': sectionNameTwo,
      'section_three': sectionNameThree,
      'section_four': sectionNameFour
    };
  }

  factory WidgetSectionState.fromMap(Map<String, dynamic> map) {
    return WidgetSectionState(
        sectionNameOne: map['section_one'],
        sectionNameTwo: map['section_two'],
        sectionNameThree: map['section_three'],
        sectionNameFour: map['section_four']
    );
  }

  String toJson() => json.encode(toMap());

  factory WidgetSectionState.fromJson(
      String sectionNameOne,
      String sectionNameTwo,
      String sectionNameThree,
      String sectionNameFour
      ) => WidgetSectionState(
      sectionNameOne: json.decode(sectionNameOne),
      sectionNameTwo: json.decode(sectionNameTwo),
      sectionNameThree: json.decode(sectionNameThree),
      sectionNameFour: json.decode(sectionNameFour)
  );
}

class WidgetSectionStateCopy extends WidgetSectionState {
  WidgetSectionStateCopy({
    required String sectionNameOne,
    required String sectionNameTwo,
    required String sectionNameThree,
    required String sectionNameFour
  }) : super(
      sectionNameOne: sectionNameOne,
      sectionNameTwo: sectionNameTwo,
      sectionNameThree: sectionNameThree,
      sectionNameFour: sectionNameFour
  );
}