import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

  Future<Map<String, dynamic>> getJournal(i) async{
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
      "journalEntry": journalEntry
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
    return jsonData["gratitude"].map<String>((entry) => entry["title"]).toList();
  }

  Future<int> getGratitudeLength() async {
    await readJson();
    return jsonData["gratitude"].length;
  }

  postGratitude(String title, String mood, String gratitudeEntry) async {
    await readJson();
    Map<String, String> newEntry = {
      "title": title,
      "mood": mood,
      "gratitudeEntry": gratitudeEntry
    };
    jsonData["gratitude"].add(newEntry);
    writeJson();
  }

}