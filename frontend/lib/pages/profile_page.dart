import '../components/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/localeprovider.dart';
import '../components/my_colours.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: "Profile"),
      body: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
        color: MyColours.teal,
        borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            Text(
              'Language',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24.0,
              )
            ),
            DropdownButton<Locale>(
              value: localeProvider.locale,

              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  localeProvider.setLocale(newLocale);
                }
              },
              items: [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text('العربية'),
                ),
                DropdownMenuItem(
                  value: Locale('hi'),
                  child: Text('हिन्दी'),
                ),
                DropdownMenuItem(
                  value: Locale('bn'),
                  child: Text('বাংলা'),
                ),
                DropdownMenuItem(
                  value: Locale('zh'),
                  child: Text('繁體'),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}