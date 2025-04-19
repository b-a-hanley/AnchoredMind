import 'package:frontend/objectbox.g.dart';
import 'package:intl/intl.dart';
import '../models/page_action.dart';
import '../controllers/abstract_controller.dart';

class ActionController extends BaseController<PageAction> {

  ActionController(Store store) {
    box = store.box<PageAction>();
  }

  int putActionStr(String actionStr) {
    return put(
      PageAction(
        action: actionStr,
        time: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())
      )
    );
  }

  List<PageAction> search(String text) {
    Query<PageAction> query = box.query(
    PageAction_.action.contains(text, caseSensitive: false)
        .or(PageAction_.time.contains(text, caseSensitive: false))
    ).build();

    List<PageAction> found = query.find();
    query.close();
    return found;
  }

}