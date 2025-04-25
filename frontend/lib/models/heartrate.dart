import 'package:objectbox/objectbox.dart';

@Entity()
class Heartrate{
  @Id()
  int id;
  int loginId;
  String heartrate;
  String time;

  Heartrate({
    this.id = 0,
    required this.loginId,
    required this.heartrate,
    required this.time
  });
}