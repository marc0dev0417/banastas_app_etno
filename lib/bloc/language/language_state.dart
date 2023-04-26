part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final String languageCode;

  LanguageState({required this.languageCode});

  factory LanguageState.initial(){
      return LanguageState(languageCode: 'es');
  }

  LanguageState copyWith({String? languageCode}){
    return LanguageState(languageCode: languageCode ?? this.languageCode);
  }

  @override
  String toString() {
    return 'LanguageState{languageCode: $languageCode}';
  }

  @override
  List<Object?> get props => [languageCode];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() => {'language_code': languageCode};
  String toJson() => json.encode(toMap());
  factory LanguageState.fromMap(Map<String, dynamic> map) => LanguageState(languageCode: map['language_code']);
  factory LanguageState.fromJson(String languageCode) => LanguageState(languageCode: json.decode(languageCode));
}

class LanguageCodeStateCopy extends LanguageState {
  LanguageCodeStateCopy({ required String languageCode }) : super(languageCode: languageCode);
}