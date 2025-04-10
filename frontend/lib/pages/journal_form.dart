import 'package:flutter/material.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/pages/journal_list_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../services/json_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class JournalForm extends StatefulWidget {
  const JournalForm({super.key});
  
  @override
  JournalFormState createState() => JournalFormState();  // Returning the state of the widget
}

class JournalFormState extends State<JournalForm> {
  final jsonService = JsonService();
  final formKey = GlobalKey<FormState>(); // Key to track form state
  final TextEditingController titleController = TextEditingController();
  final TextEditingController moodController = TextEditingController();
  final TextEditingController journalController = TextEditingController();
  String mood = "";
  int intensity = 0;
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

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      String title = titleController.text;
      String mood = moodController.text;
      String journal = journalController.text;
      String moodAdverb = moodLevel[intensity];

      jsonService.postJournal(title, mood, moodAdverb, selectedDate, journal);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JournalListPage()),
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Journal Added!')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    titleController.dispose();
    moodController.dispose();
    journalController.dispose();
    super.dispose();
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
                  TextFormField(
                    controller: titleController,
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
                          controller: moodController,
                          label: Text("Mood"),
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
                    controller: journalController,
                    decoration: InputDecoration(
                      labelText: 'Journal Entry',
                      border: OutlineInputBorder(),
                      hintText: 'Woke up feeling a bit overwhelmed by the tasks ahead. Took a few minutes to breathe deeply and recite a calming affirmation: "I am in control of my day, and I choose peace." Felt more grounded afterward. Planning to take regular breaks throughout the day to stay centered.',
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
              name: AppLocalizations.of(context)!.addNew,
              icon: Icons.add,
              onPressed: _submitForm,
            ),
          ]
        ),),
      ),
    );
  }
}
