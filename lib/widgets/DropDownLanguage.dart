import 'package:etno_app/bloc/language/language_bloc.dart';
import 'package:etno_app/provider/locale_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';

class LanguagePickerWidget extends StatelessWidget {
  const LanguagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return DropdownButtonHideUnderline(
        child: DropdownButton(
          iconEnabledColor: Colors.white,
          value: Locale(context.watch<LanguageBloc>().state.languageCode),
          items: L10n.all.map((locale){
            final flag = L10n.getFlag(locale.languageCode);
            return DropdownMenuItem(
              value: locale,
              child: Center(
                  child: Image.asset(flag, width: 25.0, height: 25.0)
              ),
              onTap: () {
                final provider = Provider.of<LocaleProvider>(context, listen: false);
                context.read<LanguageBloc>().add(SaveLanguageCode(languageCode: locale.languageCode));
                provider.setLocale(locale);
              },
            );
          }).toList(), onChanged: (Locale? value) {
        },
          dropdownColor: Color.fromRGBO(255, 255, 255, 0.45),
        )
    );
  }
}

Locale getLocaleLanguage(String languageCode){
  switch(languageCode){
    case 'es': return Locale('es');
    case 'en': return Locale('en');
    case 'ca': return Locale('ca');
    case 'eu': return Locale('eu');
    case 'fr': return Locale('fr');
    case 'gl': return Locale('gl');
    default: return Locale('es');
  }
}