import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/agreement_page.dart';
import './controllers/controller_manager.dart';
import 'languages/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //creates accesses dot env
  await dotenv.load(fileName: ".env");
  //creates objectBox store
  await ControllerManager.instance.init();
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
     //calls current instance of locale provider
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all, //calls class of available languages
      locale: localeProvider.locale, //use selected locale
      localizationsDelegates: const [
        AppLocalizations.delegate, //controls app localisations
        GlobalMaterialLocalizations.delegate, //control material localisations
        GlobalWidgetsLocalizations.delegate, //controls text direction
      ],
      home: AgreementPage(),
    );
  }
}