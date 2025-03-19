import 'package:flutter/material.dart';
import 'package:frontend/components/my_button.dart';
import 'package:frontend/pages/journal_list_page.dart';
import '../components/my_app_bar.dart';
import '../components/my_colours.dart';
import '../services/json_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewJournalForm extends StatefulWidget {
  
  @override
  _NewJournalFormState createState() => _NewJournalFormState();  // Returning the state of the widget
}

class _NewJournalFormState extends State<NewJournalForm> {
  final jsonService = JsonService();
  final _formKey = GlobalKey<FormState>(); // Key to track form state
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _moodController = TextEditingController();
  final TextEditingController _journalEntryController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String mood = _moodController.text;
      String journalEntry = _journalEntryController.text;
      
      jsonService.postJournal(title, mood, journalEntry);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JournalListPage()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted!')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _moodController.dispose();
    _journalEntryController.dispose();
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
        key: _formKey,
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
                    controller: _titleController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                      hintText: 'The day of the woods',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _moodController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Mood',
                      border: OutlineInputBorder(),
                      hintText: 'Calm',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mood';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    minLines: 3,
                    maxLines: 16,
                    controller: _journalEntryController,
                    decoration: InputDecoration(
                      labelText: 'Journal Entry',
                      border: OutlineInputBorder(),
                      hintText: 'The air was thick with the scent of damp earth and pine, and the soft crunch of leaves beneath my boots was the only sound as I wandered deeper into the woods. The sun had begun its slow descent, filtering through the skeletal branches in golden beams, setting the forest aglow in an amber haze. It was the kind of evening that felt like a whispered secret, something meant only for those who dared to listen. As I followed the meandering path, a hush fell over the trees. The birds, which had been chattering endlessly just moments before, fell silent. A breeze curled around me, its chill biting against my skin, yet the air carried something warm—something electric. Then I saw it. At the center of a small clearing, bathed in twilight, stood a figure—translucent and shimmering, as if woven from the very light that spilled through the canopy. It was neither man nor woman, neither young nor old. Their form shifted like mist caught in the wind, yet their presence was undeniable. My breath hitched. I should have been afraid, but the fear never came. Instead, a profound calm settled over me, as if I had stepped into a dream where time had unraveled, leaving only the present moment. The figure lifted a hand, and though their lips did not move, I felt words press against my mind—not spoken, but understood. You have found the place where the veil is thin. My pulse hammered in my ears. The veil? Between what? I wanted to ask, but before my thoughts could form into words, the figure turned, gliding through the clearing and vanishing into the dense thicket beyond. The golden light flickered and dimmed. The forest exhaled, and suddenly, the birds resumed their song. I stood there for what felt like hours, but when I finally glanced at my watch, only minutes had passed. My fingers trembled as I pulled my journal from my pack and scrawled down every detail, unwilling to let the moment slip away. What had I seen? A spirit? A trick of the light? Or something else entirely—something beyond words, beyond reason? I don’t know. But I do know this: the woods will never feel the same again.',
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
