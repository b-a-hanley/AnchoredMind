import 'package:objectbox/objectbox.dart';

@Entity()
class PageAction{
  @Id()
  int id;
  int loginId;
  String action;
  String time;

  PageAction({
    this.id = 0,
    required this.loginId,
    required this.action,
    required this.time,
  });
}