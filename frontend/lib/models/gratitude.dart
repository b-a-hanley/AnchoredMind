import 'package:objectbox/objectbox.dart';

@Entity()
class Gratitude{
  @Id()
  int id;
  int loginId;
  String prompt;
  String gratitude;
  String time;

  Gratitude({
    this.id = 0,
    required this.loginId,
    required this.prompt,
    required this.gratitude,
    required this.time
  });
}