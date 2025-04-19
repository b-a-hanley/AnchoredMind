import 'package:flutter/material.dart';
import '../controllers/gratitude_controller.dart';
import '../services/encrypt_service.dart';
import 'package:intl/intl.dart';
import '../controllers/controller_manager.dart';
import '../models/gratitude.dart';
import '../pages/gratitude_list_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../components/my_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GratitudeForm extends StatefulWidget {

  @override
  GratitudeFormState createState() => GratitudeFormState();
}

class GratitudeFormState extends State<GratitudeForm> {
  final List<String> list = <String> [
    "a person who has positively impacted your life",
    "a small act of kindness someone did for you",
    "a challenge you overcame and how it shaped you",
    "a natural wonder that fills you with awe",
    "a time when someone forgave you",
    "a gift that you have enjoyed more than you expected"
    "three things you appreciate about nature",
    "something brings you joy",
    "someone has supported you during difficult times",
    "a time you felt truly at peace",
    "a time when you felt content",
    "a moment when you helped someone in need",
    "a lesson you learned from failure",
    "a compliment you received that stayed with you",
    "a book, movie, or song that inspired you",
    "a place that feels like home to you",
    "a moment of unexpected beauty you witnessed",
    "a friendship that changed your life",
    "something you're proud of accomplishing recently",
    "a time you felt deeply connected to someone",
    "a tradition that holds special meaning for you",
    "a dream or goal you're working toward",
    "something you've let go of that brought healing",
    "a time you stood up for yourself or someone else",
    "a piece of advice that changed your perspective",
    "a memory that always makes you smile",
    "a way you've grown in the past year",
    "something about your culture or background you value",
    "a moment you felt truly seen or heard",
    "a hobby or activity that makes you lose track of time",
    "a quote or phrase you return to often",
    "a time you embraced change and it paid off",
    "a person whose strength inspires you",
    "a way you've shown love to yourself recently",
    "someone who made you laugh when you needed it most",
    "a lesson you learned from a difficult situation",
    "a time you stepped outside your comfort zone",
    "someone who helped you discover a new passion",
    "a goal you've set for the future and why it matters",
    "a time you gave something up for a greater cause",
    "something in nature that always leaves you in awe",
    "a difficult decision you had to make and its outcome",
    "someone who taught you an important life skill",
    "a moment that reminded you of what truly matters",
    "a fear you faced and what it taught you",
    "a book, film, or song that changed your perspective",
    "a challenge you are currently facing and how you're handling it",
    "a piece of advice that helped you overcome a setback",
    "someone you admire for their resilience",
    "a personal accomplishment that took time and effort",
    "a skill you recently learned that you're proud of",
    "a tradition or ritual you hold dear",
    "a memory that has shaped who you are today",
    "a relationship that taught you valuable lessons",
    "a way you've helped others that made you feel fulfilled",
    "a moment when you felt like you truly belonged",
    "a piece of wisdom you always carry with you",
    "something you've recently let go of to grow",
    "a risk you took that paid off in the end",
    "someone who you can count on no matter what",
    "a time when you had to stand firm in your beliefs",
    "a random act of kindness that impacted your day",
    "a goal you're currently working on and its significance",
    "something that challenges you to become a better person",
    "a time when you had to adapt quickly to a change",
    "someone who constantly inspires you with their actions",
    "a dream you are working to make a reality",
    "a time when you felt truly empowered",
    "a moment when you took a chance on yourself",
    "something that brought you peace during a stressful time"
  ];

  String dropdown1Value = "";
  String dropdown2Value = "";
  String dropdown3Value = "";
  List<String> dropdown1Values = [];
  List<String> dropdown2Values = [];
  List<String> dropdown3Values = [];

  @override
  void initState() {
    super.initState();
    list.shuffle();
    dropdown1Values = list.take(3).toList();
    dropdown2Values = list.getRange(3,6).toList();
    dropdown3Values = list.getRange(7,10).toList();
    dropdown1Value = list[0];
    dropdown2Value = list[3];
    dropdown3Value = list[6];
  }

  final GratitudeController gratitudeController = ControllerManager.instance.gratitudeController;
  final formKey = GlobalKey<FormState>(); 
  final EncryptService encryptService = EncryptService();
  final TextEditingController prompt1TEController = TextEditingController();
  final TextEditingController gratitude1TEController = TextEditingController();
  final TextEditingController prompt2TEController = TextEditingController();
  final TextEditingController gratitude2TEController = TextEditingController();
  final TextEditingController prompt3TEController = TextEditingController();
  final TextEditingController gratitude3TEController = TextEditingController();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      String prompt1 = prompt1TEController.text;
      String gratitude1 = gratitude1TEController.text;
      String prompt2 = prompt2TEController.text;
      String gratitude2 = gratitude2TEController.text;
      String prompt3 = prompt3TEController.text;
      String gratitude3 = gratitude3TEController.text;
      String time = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
      gratitudeController.put(
        Gratitude(
          prompt: prompt1,
          gratitude: encryptService.encrypt(gratitude1),
          time: time
        ) 
      );
      gratitudeController.put(
        Gratitude(
          prompt: prompt2,
          gratitude: encryptService.encrypt(gratitude2),
          time: time
        ) 
      );
      gratitudeController.put(
        Gratitude(
          prompt: prompt3,
          gratitude: encryptService.encrypt(gratitude3),
          time: time
        ) 
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GratitudeListPage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gratitude added!')),
      );
    }
  }

  @override
  void dispose() {
    prompt1TEController.dispose();
    gratitude1TEController.dispose();
    prompt2TEController.dispose();
    gratitude2TEController.dispose();
    prompt3TEController.dispose();
    gratitude3TEController.dispose();
    super.dispose();
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
                  DropdownMenu<String>(
                    controller: prompt1TEController,
                    label: Text("Choose a prompt"),
                    onSelected: (String? value) {
                      setState(() {
                        dropdown1Value = value!;
                      });
                    },
                    dropdownMenuEntries: dropdown1Values.map(
                      (String query) {
                        return DropdownMenuEntry<String>(
                          value: query,
                          label: query,
                        );
                      },
                    ).toList()
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: gratitude1TEController,
                    maxLines: null,
                    decoration: InputDecoration(
                      fillColor: MyColours.lightTeal,
                      labelText: writeAbout(dropdown1Value),
                      border: OutlineInputBorder(),
                      hintText: writeAbout(dropdown1Value),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your response';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  DropdownMenu<String>(
                      controller: prompt2TEController,
                      label: Text("Choose a prompt"),
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdown2Value = value!;
                        });
                      },
                      dropdownMenuEntries: dropdown2Values.map(
                        (String query) {
                          return DropdownMenuEntry<String>(
                            value: query,
                            label: query,
                          );
                        },
                      ).toList()
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: gratitude2TEController,
                    maxLines: null,
                    decoration: InputDecoration(
                      fillColor: MyColours.lightTeal,
                      labelText: writeAbout(dropdown2Value),
                      border: OutlineInputBorder(),
                      hintText: writeAbout(dropdown2Value),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  DropdownMenu<String>(
                      controller: prompt3TEController,
                      label: Text("Choose a prompt"),
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdown3Value = value!;
                        });
                      },
                      dropdownMenuEntries: dropdown3Values.map(
                        (String query) {
                          return DropdownMenuEntry<String>(
                            value: query,
                            label: query,
                          );
                        },
                      ).toList()
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: gratitude3TEController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: writeAbout(dropdown3Value),
                      border: OutlineInputBorder(),
                      hintText: writeAbout(dropdown3Value),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                ]),
              ),
            MyButton(
              name: AppLocalizations.of(context)!.add,
              icon: Icons.add,
              onPressed: submitForm,
            ),
          ]
        ),
      ),
      ),
    );
  }
}
