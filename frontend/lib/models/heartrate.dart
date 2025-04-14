import 'package:objectbox/objectbox.dart';

@Entity()
class Heartrate{
  @Id()
  int id;
  String heartrate;
  String time;

  Heartrate({
    this.id = 0,
    required this.heartrate,
    required this.time
  });
}