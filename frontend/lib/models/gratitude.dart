import 'package:objectbox/objectbox.dart';

@Entity()
class Gratitude{
  @Id()
  int id;
  String prompt;
  String gratitude;
  String time;

  Gratitude({
    this.id = 0,
    required this.prompt,
    required this.gratitude,
    required this.time
  });
}