import 'package:objectbox/objectbox.dart';

@Entity()
class Profile{
  @Id()
  int id;
  String language;
  String heartrateDevice;
  String login;
  String password;

  Profile({
    this.id = 0,
    required this.language,
    required this.heartrateDevice,
    required this.login,
    required this.password,
  });
}