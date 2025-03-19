import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.journal),
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
              'Title',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24.0,
                decoration: TextDecoration.underline,
              ),
            ),Text(
              '',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            Text(
              'Body',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24.0,
                decoration: TextDecoration.underline,
              ),
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
