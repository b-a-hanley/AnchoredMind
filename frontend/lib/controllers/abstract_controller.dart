import '../objectbox.g.dart';

abstract class BaseController<T> {
  
  late final Box<T> box;  
  
  List<T> getAll() => box.getAll();

  T? get(int id) => box.get(id);

  int put(T item) => box.put(item);

  bool delete(int id) => box.remove(id);

  int getCount() => box.count();

}