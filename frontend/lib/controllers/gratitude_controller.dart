import 'package:frontend/objectbox.g.dart';
import '../models/gratitude.dart';
import '../controllers/abstract_controller.dart';

class GratitudeController extends BaseController<Gratitude> {

  late final Box<Gratitude> _box;

  GratitudeController(Store store) {
    _box = store.box<Gratitude>();
  }

  List<Gratitude> search(String text) {
    Query<Gratitude> query = _box.query(
        Gratitude_.prompt.contains(text, caseSensitive: false)
          .or(Gratitude_.time.contains(text, caseSensitive: false))
    ).build();

    List<Gratitude> found = query.find();
    query.close();
    return found;
  }

}