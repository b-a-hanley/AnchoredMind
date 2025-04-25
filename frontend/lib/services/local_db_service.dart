import 'package:frontend/models/page_action.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:intl/intl.dart';
import '../models/journal.dart';
import '../models/gratitude.dart';
import '../models/heartrate.dart';
import '../models/profile.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LocalDBService {
  static final LocalDBService _instance = LocalDBService._internal();
  late final Store store;
  late final Box<Journal> journalBox;
  late final Box<Profile> profileBox;
  late final Box<Gratitude> gratitudeBox;
  late final Box<Heartrate> heartrateBox;
  late final Box<PageAction> actionBox;

  LocalDBService._internal();

  static LocalDBService get instance => _instance;

  Future<void> init() async {
    //get location to store database
    final docsDir = await getApplicationDocumentsDirectory();
    //create database in location
    store = await openStore(directory: path.join(docsDir.path, "objectbox"));
    //create database entities
    journalBox = store.box<Journal>();
    gratitudeBox = store.box<Gratitude>();
    profileBox = store.box<Profile>();
    heartrateBox = store.box<Heartrate>();
    actionBox = store.box<PageAction>();
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
        loginId: AuthService().getLogin,
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
        loginId: AuthService().getLogin,
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

  int putGratitude(Gratitude gratitude) {  
    return gratitudeBox.put(gratitude);
  }

  bool deleteGratitude(int id) {  
    return gratitudeBox.remove(id);
  }

  List<Heartrate> getAllHeartrates() {
    return heartrateBox.getAll();
  }

  List<Heartrate> searchHeartrates(String text) {
    Query<Heartrate> query = heartrateBox.query(
    Heartrate_.heartrate.contains(text, caseSensitive: false)
        .or(Heartrate_.time.contains(text, caseSensitive: false))
    ).build();

    List<Heartrate> found = query.find();
    query.close();
    return found;
  }

  Heartrate getHeartrate(int id) {
    Heartrate? heartrate = heartrateBox.get(id);
    if (heartrate == null) {
      return Heartrate(
        loginId: AuthService().getLogin,
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

  int putHeartrate(heartrate) {
    return heartrateBox.put(
      Heartrate(
        loginId: AuthService().getLogin,
        heartrate: heartrate,
        time: DateTime.now().toString()
      )
    );
  }

  void putProfile({String? language, String? heartrateDevice}) {
    Profile? currentProfile = getProfile();
    Profile newProfile;
    if (currentProfile==null) {
      newProfile = Profile(
        id: 1,
        language: language ?? "en",
        heartrateDevice: heartrateDevice ?? "",
        login: "login",
        loginHash: "login",
        password: "Password1",
      );
    }
    else {
      newProfile = Profile(
        language: language ?? currentProfile.language,
        heartrateDevice: heartrateDevice ?? currentProfile.heartrateDevice,
        login: "login",
        loginHash: "login",
        password: "Password1",
      );
    }
    profileBox.put(newProfile);
  }

  Profile? getProfile() {  
    return profileBox.get(1);
  }

  String? getProfileHeartrateDevice() {
    return profileBox.get(1)!.heartrateDevice;
  }

  String? getProfileLanguage() {
    return profileBox.get(1)!.language;
  }

  String getProfileLogin() {
    return profileBox.get(1)!.login;
  }

  String getProfilePassword() {
    return profileBox.get(1)!.password;
  }

  void putAction(String action) {
    actionBox.put(PageAction(
      loginId: AuthService().getLogin,
      action: action,
      time: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())
    ));
  }

  List<PageAction> getAllActions() {
    return actionBox.getAll();
  }

  List<PageAction> searchActions(String text) {
    Query<PageAction> query = actionBox.query(
    PageAction_.action.contains(text, caseSensitive: false)
        .or(PageAction_.time.contains(text, caseSensitive: false))
    ).build();

    List<PageAction> found = query.find();
    query.close();
    return found;
  }
  
}