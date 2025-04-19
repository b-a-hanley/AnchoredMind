import '../objectbox.g.dart';

abstract class BaseController<T> {
  
  late final Box<T> _box;  
  
  List<T> getAll() => _box.getAll();

  T? get(int id) => _box.get(id);

  int put(T item) => _box.put(item);

  bool delete(int id) => _box.remove(id);

  int getCount() => _box.count();

}