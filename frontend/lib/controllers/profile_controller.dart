import 'package:flutter/material.dart';
import 'package:frontend/objectbox.g.dart';
import 'package:frontend/services/encrypt_service.dart';
import '../models/profile.dart';
import '../controllers/abstract_controller.dart';

class ProfileController extends BaseController<Profile> {
  EncryptService encryptService = EncryptService();

  ProfileController(Store store) {
    box = store.box<Profile>();
  }

  void init({String? language, String? heartrateDevice}) {
    Profile? currentProfile = box.get(1);

    print("Password Initialised");
    if (currentProfile!=null) return;
    box.put(
      Profile(
        language: language ?? "en",
        heartrateDevice: heartrateDevice ?? "",
        login: encryptService.encrypt("login"),
        loginHash: encryptService.hashLogin("login"),
        password: encryptService.encrypt("Password1"),
      )
    );
  }

  void putAttribute({String? login, String? password, String? language, String? heartrateDevice}) {
    Profile? currentProfile = box.get(authService.getLogin)!;
    int id = 0;
    //are we changing login details
    if (login==null) {
      id = authService.getLogin;
    }
    else {
      //does login exist
      currentProfile = searchLogin(login);
      if (currentProfile!=null) {
        //add current id
        id=currentProfile.id;
      }
      else {
        //create new profile
        authService.login(
            box.put(
              Profile(
                language: language ?? "en",
                heartrateDevice: heartrateDevice ?? "",
                login: encryptService.encrypt(login),
                loginHash: encryptService.hashLogin(login),
                password: encryptService.encrypt(password!),
              )
            )
        );
        return;
      }
    } //update all values
    authService.login(
      box.put(
        Profile(
          id: id,
          language: encryptService.encrypt(language ?? currentProfile.language),
          heartrateDevice: encryptService.encrypt(heartrateDevice ?? currentProfile.heartrateDevice),
          login: encryptService.encrypt(login ?? currentProfile.login),
          loginHash: encryptService.hashLogin(login ?? currentProfile.login),
          password: encryptService.encrypt(password ?? currentProfile.password),
        )
      )
    );
    authService.login(id);
  }
  
  String? getHeartrateDevice(BuildContext context) {
    return box.get(authService.getLogin)!.heartrateDevice;
  }

  String? getLanguage(BuildContext context) {
    return box.get(authService.getLogin)!.language;
  }

  Profile? searchLogin(String login) {
    final loginHash = encryptService.hashLogin(login);
    final query = box.query(
      Profile_.loginHash.equals(loginHash, caseSensitive: false)
    ).build();

    final result = query.findFirst();
    query.close();
    print("login ${(result==null)? "not" : "is"} found!");
    return result;
  }
  
  @override
  List<Profile> getAll() {
    throw UnimplementedError();
  }
  
  @override
  List<Profile> search(String text) {
    throw UnimplementedError();
  }
  
  @override
  int itemLoginId(Profile item) {
    throw UnimplementedError();
  }

}