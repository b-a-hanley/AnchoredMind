import '../l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/LocaleProvider.dart';
import 'pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: AnchoredMind(),
    ),
  );
}

class AnchoredMind extends StatelessWidget {
  const AnchoredMind({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      locale: localeProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: HomePage(),
    );
  }
}