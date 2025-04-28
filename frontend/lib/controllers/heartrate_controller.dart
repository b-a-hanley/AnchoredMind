import 'package:frontend/objectbox.g.dart';
import '../models/heartrate.dart';
import '../controllers/abstract_controller.dart';

class HeartrateController extends BaseController<Heartrate> {
  
  HeartrateController(Store store) {
    box = store.box<Heartrate>();
  }

  @override
  int itemLoginId(Heartrate item) {
    return item.loginId;
  }

  @override
  List<Heartrate> getAll() {
    final query = box.query(
      Heartrate_.loginId.equals(authService.getLogin)
    ).build();

    List<Heartrate> results = query.find();
    query.close();
    return results;
  }

  @override
  List<Heartrate> search(String text) {
    Query<Heartrate> query = box.query(
      Heartrate_.heartrate.contains(text, caseSensitive: false)
        .or(Heartrate_.time.contains(text, caseSensitive: false))
        .and(Heartrate_.loginId.equals(authService.getLogin))
    ).build();

    List<Heartrate> found = query.find();
    query.close();
    return found;
  }

}