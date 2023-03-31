import 'dart:ui';

class L10n {
  static final all = [
    const Locale('es'),
    const Locale('en'),
    const Locale('fr'),
    const Locale('eu'),
    const Locale('ca'),
    const Locale('gl')
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'es': return 'assets/spain_flag.png';
      case 'en': return 'assets/uk.jpg';
      case 'fr': return 'assets/france.png';
      case 'eu': return 'assets/pais_vasco.png';
      case 'ca': return 'assets/cataluna.png';
      case 'gl': return 'assets/galicia.jpg';
      default: return 'assets/spain_flag.png';
    }
  }
}