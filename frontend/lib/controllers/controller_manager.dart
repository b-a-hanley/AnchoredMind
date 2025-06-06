import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../objectbox.g.dart';
import '../controllers/action_controller.dart';
import '../controllers/journal_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/gratitude_controller.dart';
import '../controllers/heartrate_controller.dart';

class ControllerManager {
  late final Store _store;

  late final JournalController journalController;
  late final ActionController actionController;
  late final ProfileController profileController;
  late final GratitudeController gratitudeController;
  late final HeartrateController heartrateController;

  static final ControllerManager _instance = ControllerManager._internal();
  ControllerManager._internal();
  static ControllerManager get instance => _instance;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _store = await openStore(
      directory: path.join(dir.path, "objectbox"),
    );

    journalController = JournalController(_store);
    actionController = ActionController(_store);
    profileController = ProfileController(_store);
    gratitudeController = GratitudeController(_store);
    heartrateController = HeartrateController(_store);
  }

}
