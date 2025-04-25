import 'package:frontend/services/auth_service.dart';
import '../objectbox.g.dart';

abstract class BaseController<T> {
  AuthService authService = AuthService();
  late final Box<T> box;

  //these will be overriden
  List<T> getAll();
  List<T> search(String text);
  int itemLoginId(T item);

  T? get(int id) {
    final item = box.get(id);
    if (item != null && itemLoginId(item) == authService.getLogin) return item;
    return null; // access denied
  }

  int put(T item) {
    if (itemLoginId(item) != authService.getLogin) {
      throw Exception("Unauthorised");
    }
    return box.put(item);
  }

  bool delete(int id) {
    final item = box.get(id);
    if (item != null && itemLoginId(item) == authService.getLogin) {
      return box.remove(id);
    }
    return false;
  }

}