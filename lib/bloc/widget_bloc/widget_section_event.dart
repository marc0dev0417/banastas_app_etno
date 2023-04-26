part of 'widget_section_bloc.dart';

abstract class WidgetSectionEvent extends Equatable{

}
class FilterWidgetSection extends WidgetSectionEvent {
  final int buttonIndex;
  final String sectionName;

  FilterWidgetSection({required this.buttonIndex, required this.sectionName});

  @override
  List<Object?> get props => [buttonIndex, sectionName];
}