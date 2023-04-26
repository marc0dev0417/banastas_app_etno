part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
}

class SaveLanguageCode extends LanguageEvent {
  final String languageCode;
  
  SaveLanguageCode({required this.languageCode});
  
  @override
  List<Object?> get props => [languageCode];
}
