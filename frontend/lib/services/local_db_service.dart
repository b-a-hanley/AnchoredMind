import '../models/journal.dart';
import '../models/gratitude.dart';
import '../models/heartrate.dart';
import '../models/profile.dart';
import '../models/state.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LocalDBService {
  static final LocalDBService _instance = LocalDBService._internal();
  late final Store _store;
  late final Box<Journal> journalBox;
  late final Box<Profile> profileBox;
  late final Box<Gratitude> gratitudeBox;
  late final Box<Heartrate> heartrateBox;
  late final Box<State> stateBox;

  LocalDBService._internal();

  static LocalDBService get instance => _instance;

  Future<void> init() async {
    final docsDir = await getApplicationDocumentsDirectory();
    _store = await openStore(directory: path.join(docsDir.path, "objectbox"));
    journalBox = _store.box<Journal>();
    gratitudeBox = _store.box<Gratitude>();
  }

  List<Journal> getAllJournals() {
    return journalBox.getAll();
  }

  List<Journal> searchJournals(String text) {
    Query<Journal> query = journalBox.query(
    Journal_.title.contains(text, caseSensitive: false)
        .or(Journal_.journal.contains(text, caseSensitive: false))
        .or(Journal_.mood.contains(text, caseSensitive: false))
        .or(Journal_.time.contains(text, caseSensitive: false))
    ).build();

    List<Journal> found = query.find();
    query.close();
    return found;
  }

  Journal getJournal(int id) {  
    Journal? journal = journalBox.get(id);
    if (journal == null) {
      return Journal(
        title: "No title",
        mood: "No mood",
        intensity: "No intensity",
        time: "No time",
        journal: "No journal"
      );
    }
    else {
      return journal;
    }
  }

  int getJournalLength() {  
    return journalBox.count();
  }

  int postJournal(Journal journal) {  
    return journalBox.put(journal);
  }

  int putJournal(Journal journal) {  
    return journalBox.put(journal);
  }

  bool deleteJournal(int id) {  
    return journalBox.remove(id);
  }

  List<Gratitude> getAllGratitudes() {
    return gratitudeBox.getAll();
  }

  List<Gratitude> searchGratitudes(String text) {
    Query<Gratitude> query = gratitudeBox.query(
        Gratitude_.prompt.contains(text, caseSensitive: false)
            .or(Gratitude_.gratitude.contains(text, caseSensitive: false))
            .or(Gratitude_.time.contains(text, caseSensitive: false))
    ).build();

    List<Gratitude> found = query.find();
    query.close();
    return found;
  }

  Gratitude getGratitude(int id) {  
    Gratitude? gratitude = gratitudeBox.get(id);
    if (gratitude == null) {
      return Gratitude(
        prompt: "No prompt",
        gratitude: "No gratitude",
        time: "No time"
      );
    }
    else {
      return gratitude;
    }
  }

  int getGratitudeLength() {  
    return gratitudeBox.count();
  }

  int postGratitude(Gratitude gratitude) {  
    return gratitudeBox.put(gratitude);
  }

  int putGratitude(Gratitude gratitude) {  
    return gratitudeBox.put(gratitude);
  }

  bool deleteGratitude(int id) {  
    return gratitudeBox.remove(id);
  }

  List<Heartrate> getAllHeartrates() {
    return heartrateBox.getAll();
  }

  Heartrate getHeartrate(int id) {
    Heartrate? heartrate = heartrateBox.get(id);
    if (heartrate == null) {
      return Heartrate(
          heartrate: "No heartrate",
          time: "No time"
      );
    }
    else {
      return heartrate;
    }
  }

  int getHeartrateLength() {
    return heartrateBox.count();
  }

  int putHeartrate(Heartrate heartrate) {
    return heartrateBox.put(heartrate);
  }
  
}