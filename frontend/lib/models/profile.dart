import 'package:objectbox/objectbox.dart';

@Entity()
class Profile{
  @Id()
  int id;
  String language;
  String heartrateMonitor;
  String login;
  String password;

  Profile({
    this.id = 0,
    required this.language,
    required this.heartrateMonitor,
    required this.login,
    required this.password,
  });
}