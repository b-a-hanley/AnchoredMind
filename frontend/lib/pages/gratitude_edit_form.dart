import 'package:flutter/material.dart';
import '../models/gratitude.dart';
import '../services/local_db_service.dart';
import '../pages/gratitude_list_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../components/my_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GratitudeEditForm extends StatefulWidget {
  final int index;

  const GratitudeEditForm({super.key, this.index = 0});

  @override
  GratitudeEditFormState createState() => GratitudeEditFormState();
}

class GratitudeEditFormState extends State<GratitudeEditForm> {
  final localDbService = LocalDBService.instance;
  final formKey = GlobalKey<FormState>(); 
  final TextEditingController gratitudeController = TextEditingController();
  String prompt = "";
  String time = "";

  @override
  void initState() {
    super.initState();
    Gratitude gratitude = LocalDBService.instance.getGratitude(widget.index);
    prompt = gratitude.prompt;
    time = gratitude.time;
    gratitudeController.text = gratitude.gratitude;
  }

  @override
  void dispose() {
    gratitudeController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      String gratitude = gratitudeController.text;
      localDbService.postGratitude(
        Gratitude(
          prompt: prompt,
          gratitude: gratitude,
          time: time
        ) 
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GratitudeListPage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gratitude editted!')),
      );
    }
  }
  
  String writeAbout(String prompt) {
    return "Write about $prompt";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.gratitude),
      body: SingleChildScrollView(
        child:
        Form(
        key: formKey,
        child: Column (
          children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: MyColours.teal,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column( 
                children: [
                  SizedBox(height: 15),
                  TextFormField(
                    controller: gratitudeController,
                    maxLines: null,
                    decoration: InputDecoration(
                      fillColor: MyColours.lightTeal,
                      labelText: writeAbout(prompt),
                      border: OutlineInputBorder(),
                      hintText: writeAbout(prompt),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your response';
                      }
                      return null;
                    },
                  ),
                ]
              ),
            ),
            MyButton(
              name: AppLocalizations.of(context)!.edit,
              icon: Icons.edit,
              onPressed: submitForm,
            ),
          ]),
        ),
      ),
    );
  }
}