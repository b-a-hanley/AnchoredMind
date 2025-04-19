import 'package:frontend/objectbox.g.dart';
import '../models/heartrate.dart';
import '../controllers/abstract_controller.dart';

class HeartrateController extends BaseController<Heartrate> {

  late final Box<Heartrate> _box;
  
  HeartrateController(Store store) {
    _box = store.box<Heartrate>();
  }

  List<Heartrate> search(String text) {
    Query<Heartrate> query = _box.query(
    Heartrate_.heartrate.contains(text, caseSensitive: false)
        .or(Heartrate_.time.contains(text, caseSensitive: false))
    ).build();

    List<Heartrate> found = query.find();
    query.close();
    return found;
  }
}