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
          value: locale,
          icon: Container(
            padding: const EdgeInsets.only(right: 15.0),
            child: const Icon(Icons.language, size: 45.0),
          ),
          items: L10n.all.map((locale){
            final flag = L10n.getFlag(locale.languageCode);
            return DropdownMenuItem(
                value: locale,
                child: Center(
                  child: Text(
                    flag,
                    style: const TextStyle(fontSize: 32.0)
                  ),
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