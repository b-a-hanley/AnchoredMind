import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class JsonService {

  static JsonService? _instance;

  JsonService._internal();

  factory JsonService() {
    _instance ??= JsonService._internal();
    return _instance!;
  }

  Map<String, dynamic> jsonData = {"journal": [], "gratitude": []};

  Future<String> getLocalFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/anchoredMind.json';
  }

   readJson() async {
    if (jsonData["journal"].isNotEmpty|| jsonData["gratitude"].isNotEmpty) return null;
    final file = File(await getLocalFilePath());

    if (await file.exists()) {
      String contents = await file.readAsString();
      jsonData = jsonDecode(contents);  
    } else {return {};}
  }

  void writeJson() async {
    final file = File(await getLocalFilePath());
    String updatedJson = jsonEncode(jsonData);
    await file.writeAsString(updatedJson);
  }

  Future<Map<String, dynamic>> getAll() async{
    await readJson();
    return jsonData;
  }

  Future<Map<String, dynamic>> getJournal(int i) async{
    await readJson();
    return jsonData["journal"][i];
  }

  Future<List<String>> getJournalTitles() async {  
    await readJson();
    return jsonData["journal"].map<String>((entry) => entry["title"]).toList();
  }

  Future<int> getJournalLength() async {
    await readJson();
    return jsonData["journal"].length;
  }

  postJournal(String title, String mood, String journalEntry) async {
    await readJson();
    Map<String, String> newEntry = {
      "title": title,
      "mood": mood,
      "journalEntry": journalEntry,
      "time": DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())
    };
    jsonData["journal"].add(newEntry);
    writeJson();
  }

  Future<Map<String, dynamic>> getGratitude(i) async{
    await readJson();
    return jsonData["gratitude"][i];
  }

  Future<List<String>> getGratitudeTitles() async {
    await readJson();
    return jsonData["gratitude"].map<String>((entry) => entry["prompt"]).toList();
  }

  Future<int> getGratitudeLength() async {
    await readJson();
    return jsonData["gratitude"].length;
  }

  postGratitude(String prompt1, String gratitude1, String prompt2, String gratitude2, String prompt3, String gratitude3) async {
    await readJson();
    Map<String, String> newEntry = {
      "prompt": prompt1[0].toUpperCase() + prompt1.substring(1),
      "gratitude": gratitude1,
      "time": DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())
    };
    jsonData["gratitude"].add(newEntry);
    newEntry = {
      "prompt": prompt2[0].toUpperCase() + prompt2.substring(1),
      "gratitude": gratitude2,
      "time": DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())
    };
    jsonData["gratitude"].add(newEntry);
    newEntry = {
      "prompt": prompt3[0].toUpperCase() + prompt3.substring(1),
      "gratitude": gratitude3,
      "time": DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())
    };
    jsonData["gratitude"].add(newEntry);
    writeJson();
  }

}