import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/my_button.dart';
import '../controllers/controller_manager.dart';
import '../pages/journal_list_page.dart';
import '../services/encrypt_service.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../controllers/journal_controller.dart';
import '../models/journal.dart';
class JournalForm extends StatefulWidget {
  final int index;

  const JournalForm({super.key, this.index = 0});

  @override
  JournalFormState createState() => JournalFormState();
}

class JournalFormState extends State<JournalForm> {
  final JournalController journalController = ControllerManager.instance.journalController;
  final formKey = GlobalKey<FormState>(); // Key to track form state
  final TextEditingController titleTEController = TextEditingController();
  final TextEditingController moodTEController = TextEditingController();
  final TextEditingController journalTEController = TextEditingController();
  final EncryptService encryptService = EncryptService();
  String mood = "";
  int intensity = 0;
  String pageType = "add";
  String selectedDate = "";

  List<String> moodList = [
    "Happy", 
    "Content", 
    "Excited", 
    "Calm", 
    "Tired", 
    "Sad", 
    "Lonely", 
    "Angry", 
    "Anxious", 
    "Stressed", 
    "Bored", 
    "Confident", 
    "Frustrated", 
    "Hopeful", 
    "Overwhelmed",
  ];
  List<String> moodLevel = [
    "Mildly",
    "Slightly",
    "Somewhat",
    "Moderately",
    "Fairly",
    "Strongly",
    "Intensely"
  ];

  @override
  void initState() {
    super.initState();
    if (widget.index!=0) {
      pageType="edit";
      Journal journal = journalController.get(widget.index)!;
      titleTEController.text = journal.title;
      mood = journal.mood;
      intensity = moodLevel.indexOf(journal.intensity);
      selectedDate = journal.time;
      journalTEController.text = encryptService.decrypt(journal.journal);
    }
    else {selectedDate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());}
  }

  @override
  void dispose() {
    titleTEController.dispose();
    moodTEController.dispose();
    journalTEController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date == null) return;
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;
    final DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => selectedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime));
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      String title = titleTEController.text;
      String journal = journalTEController.text;
      String moodAdverb = moodLevel[intensity];

      journalController.put(
        Journal(
          id: widget.index,
          title: title,
          mood: mood,
          intensity: moodAdverb,
          time: selectedDate,
          journal: encryptService.encrypt(journal),
        ) 
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JournalListPage()),
      );

      if (widget.index==0){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Journal Added!')),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Journal Edited!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: MyAppBar(context, name: AppLocalizations.of(context)!.journal),
      body:
    SingleChildScrollView(
    child: Form(
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
                  //Text(widget.index.toString()),
                  TextFormField(
                    controller: titleTEController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      hintText: 'Waking up today',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity, // Makes it take full width of parent
                      child: DropdownMenu<String>(
                          label: Text("Mood"),
                          initialSelection: mood,
                          onSelected: (String? value) {
                            setState(() {
                              mood = value!;
                            });
                          },
                          dropdownMenuEntries: moodList.map(
                                (String query) {
                              return DropdownMenuEntry<String>(
                                value: query,
                                label: query,
                              );
                            },
                          ).toList()
                      )
                  ),
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Mild"),
                        Slider(
                          value: intensity.toDouble(),
                          min: 0,
                          max: 6,
                          label: "Intensity",
                          thumbColor: MyColours.backgroundGreen,
                          activeColor: MyColours.darkTeal,
                          inactiveColor: MyColours.black,
                          onChanged: (double value) {
                            setState(() {
                              intensity = value.toInt();
                            });
                          },
                        ),
                        Text("Intense")
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          selectedDate == ""
                              ? '${DateTime.now()}'
                              : 'Time: ${selectedDate}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed:pickDate,
                          child: Text(
                            'Select Date',
                            style: TextStyle(color: MyColours.backgroundGreen),
                          ),
                        ),
                      ]
                  ),
                  TextFormField(
                    minLines: 3,
                    maxLines: 16,
                    controller: journalTEController,
                    decoration: InputDecoration(
                      labelText: 'Journal Entry',
                      border: OutlineInputBorder(),
                      hintText: "Woke up feeling a bit overwhelmed by the tasks ahead. The thought of everything I needed to do today felt like a heavy weight pressing on my mind. I took a few minutes to sit in silence, focusing on my breath. Slowly inhaling and exhaling, I felt the tension start to release. After a couple of deep breaths, I recited my calming affirmation: 'I am in control of my day, and I choose peace.' The words began to settle into my mind, and I could feel my racing thoughts start to slow down. I decided to write down my tasks for the day, breaking them into smaller, more manageable steps. This helped me see that I could handle everything if I took it one thing at a time. I felt more grounded afterward, realizing that I didn’t need to rush or panic. I also planned to take regular breaks throughout the day, whether it’s stepping outside for a few minutes of fresh air or just closing my eyes to reset. Knowing I have these moments to look forward to makes the day seem less overwhelming. I also set a reminder on my phone to pause and breathe deeply, even during moments that feel busy. I’m feeling more hopeful now and ready to face whatever comes my way, knowing I can find calm even in the chaos.",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your journal entry';
                      }
                      return null;
                    },
                  ),
                ]),
              ),
              MyButton(
                name: (pageType=="edit") ? AppLocalizations.of(context)!.edit : AppLocalizations.of(context)!.add,
                icon: (pageType=="edit") ? Icons.edit : Icons.add,
                onPressed: submitForm,
              ),
            ]
          ),
        ),
      ),
    );
  }
}
