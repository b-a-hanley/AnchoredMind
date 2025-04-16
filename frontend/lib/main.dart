import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'languages/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/localeprovider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'services/local_db_service.dart';
import 'package:permission_handler/permission_handler.dart';

late LocalDBService localDbService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDBService.instance.init();
  requestPermissions();
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: AnchoredMind(),
    ),
  );
}

Future<void> requestPermissions() async {
  await [
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
    Permission.locationWhenInUse,
  ].request();
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