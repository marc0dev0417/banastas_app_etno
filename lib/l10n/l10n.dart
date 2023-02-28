import 'dart:ui';

class L10n {
  static final all = [
    const Locale('es'),
    const Locale('eu')
  ];
  static String getFlag(String code) {
    switch (code) {
      case 'es': return '🇪🇸';
      case 'eu': return '🏴󠁥󠁳󠁰󠁶󠁿';

      default: return '🇪🇸';
    }
  }
}