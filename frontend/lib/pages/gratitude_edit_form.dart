import 'package:flutter/material.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../components/my_button.dart';
import '../controllers/controller_manager.dart';
import '../controllers/gratitude_controller.dart';
import '../models/gratitude.dart';
import '../pages/gratitude_list_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../services/encrypt_service.dart';

class GratitudeEditForm extends StatefulWidget {
  final int index;

  const GratitudeEditForm({super.key, this.index = 0});

  @override
  GratitudeEditFormState createState() => GratitudeEditFormState();
}

class GratitudeEditFormState extends State<GratitudeEditForm> {
  final GratitudeController gratitudeController = ControllerManager.instance.gratitudeController;
  final formKey = GlobalKey<FormState>(); 
  final TextEditingController gratitudeTEController = TextEditingController();
  final AuthService authService = AuthService();
  final EncryptService encryptService = EncryptService();
  String prompt = "";
  String time = "";

  @override
  void initState() {
    super.initState();
    Gratitude gratitude = gratitudeController.get(widget.index)!;
    prompt = gratitude.prompt;
    time = gratitude.time;
    gratitudeTEController.text = encryptService.decrypt(gratitude.gratitude);
  }

  @override
  void dispose() {
    gratitudeTEController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      String gratitude = gratitudeTEController.text;
      gratitudeController.put(
        Gratitude(
          id: widget.index,
          loginId: authService.getLogin,
          prompt: prompt,
          gratitude: encryptService.encrypt(gratitude),
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
                    controller: gratitudeTEController,
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