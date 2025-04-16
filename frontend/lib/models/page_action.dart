import 'package:objectbox/objectbox.dart';

@Entity()
class PageAction{
  @Id()
  int id;
  String action;
  String time;

  PageAction({
    this.id = 0,
    required this.action,
    required this.time,
  });
}