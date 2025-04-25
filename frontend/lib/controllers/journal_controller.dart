import 'package:frontend/objectbox.g.dart';
import '../models/journal.dart';
import '../controllers/abstract_controller.dart';

class JournalController extends BaseController<Journal> {

  JournalController(Store store) {
    box = store.box<Journal>();
  }

  @override
  int itemLoginId(Journal item) {
    return item.loginId;
  }

  @override
  List<Journal> getAll() {
    final query = box.query(
      Journal_.loginId.equals(authService.getLogin)
    ).build();

    List<Journal> results = query.find();
    query.close();
    return results;
  }

  @override
  List<Journal> search(String text) {
    final query = box.query(
      Journal_.title.contains(text, caseSensitive: false)
        .or(Journal_.mood.contains(text, caseSensitive: false))
        .or(Journal_.time.contains(text, caseSensitive: false))
        .and(Journal_.loginId.equals(authService.getLogin))
    ).build();

    final results = query.find();
    query.close();
    return results;
  }

}