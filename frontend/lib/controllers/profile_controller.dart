import 'package:frontend/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import '../models/profile.dart';
import '../controllers/abstract_controller.dart';

class ProfileController extends BaseController<Profile> {

  late final Box<Profile> _box;

  ProfileController(Store store) {
    _box = store.box<Profile>();
  }

  void init({String? language, String? heartrateDevice}) {
    Profile? currentProfile = get(1);
    if (currentProfile!=null) return;
    put(
      Profile(
        language: language ?? "en",
        heartrateDevice: heartrateDevice ?? "",
        login: "login",
        password: "Password1",
      )
    );
  }

  void putAttribute({String? login, String? password, String? language, String? heartrateDevice}) {
    Profile currentProfile = get(1)!;
    put(Profile(
        id: 1,
        language: language ?? currentProfile.language,
        heartrateDevice: heartrateDevice ?? currentProfile.heartrateDevice,
        login: login ?? currentProfile.login,
        password: password ?? currentProfile.password,
      )
    );
  }
  
  String? getHeartrateDevice() {
    return _box.get(1)!.heartrateDevice;
  }

  String? getLanguage() {
    return _box.get(1)!.language;
  }

  String getLogin() {
    return _box.get(1)!.login;
  }

  String getPassword() {
    return _box.get(1)!.password;
  }

}