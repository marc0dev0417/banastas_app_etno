import 'dart:ui';

class L10n {
  static final all = [
    const Locale('es'),
    const Locale('eu'),
    const Locale('fr')
  ];
  static String getFlag(String code) {
    switch (code) {
      case 'es': return 'assets/spain_flag.png';
      case 'eu': return 'assets/pais_vasco.png';
      case 'fr': return 'assets/france.png';
      default: return 'assets/spain_flag.png';
    }
  }
}