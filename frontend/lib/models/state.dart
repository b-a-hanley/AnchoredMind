import 'package:objectbox/objectbox.dart';

@Entity()
class State{
  @Id()
  int id;
  String page;
  String action;

  State({
    this.id = 0,
    required this.page,
    required this.action
  });
}