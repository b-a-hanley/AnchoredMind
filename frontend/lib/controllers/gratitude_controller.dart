import 'package:frontend/objectbox.g.dart';
import '../models/gratitude.dart';
import '../controllers/abstract_controller.dart';

class GratitudeController extends BaseController<Gratitude> {

  GratitudeController(Store store) {
    box = store.box<Gratitude>();
  }

  @override
  int itemLoginId(Gratitude item) {
    return item.loginId;
  }

  @override
  List<Gratitude> getAll() {
    final query = box.query(
      Gratitude_.loginId.equals(authService.getLogin)
    ).build();

    List<Gratitude> results = query.find();
    query.close();
    return results;
  }

  @override
  List<Gratitude> search(String text) {
    Query<Gratitude> query = box.query(
        Gratitude_.prompt.contains(text, caseSensitive: false)
          .or(Gratitude_.time.contains(text, caseSensitive: false))
          .and(Gratitude_.loginId.equals(authService.getLogin))
    ).build();

    List<Gratitude> found = query.find();
    query.close();
    return found;
  }

}