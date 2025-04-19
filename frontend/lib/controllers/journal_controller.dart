import 'package:frontend/objectbox.g.dart';
import '../models/journal.dart';
import '../controllers/abstract_controller.dart';

class JournalController extends BaseController<Journal> {

  late final Box<Journal> _box;

  JournalController(Store store) {
    _box = store.box<Journal>();
  }

  List<Journal> search(String text) {
    final query = _box.query(
      Journal_.title.contains(text, caseSensitive: false)
        .or(Journal_.mood.contains(text, caseSensitive: false))
        .or(Journal_.time.contains(text, caseSensitive: false))
    ).build();

    final results = query.find();
    query.close();
    return results;
  }
}