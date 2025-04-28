import 'package:objectbox/objectbox.dart';

@Entity()
class Journal {
  int id;
  int loginId;
  String title;
  String mood;
  String intensity;
  String time;
  String journal;

  Journal({
    this.id = 0,
    required this.loginId,
    required this.title,
    required this.mood,
    required this.intensity,
    required this.time,
    required this.journal
  });
}