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
          value: locale,
          items: L10n.all.map((locale){
            final flag = L10n.getFlag(locale.languageCode);
            return DropdownMenuItem(
                value: locale,
                child: Center(
                  child: Image.asset(flag, width: 25.0, height: 25.0)
                ),
              onTap: () {
                final provider = Provider.of<LocaleProvider>(context, listen: false);
                provider.setLocale(locale);
              },
            );
          }).toList(), onChanged: (Locale? value) {  },
        )
    );
  }
}