import 'package:hive/hive.dart';

class save_hive {
  final String _boxname = "config";

  Future<Box> get _box async => await Hive.openBox(_boxname);

  //CRUD

  //create
  Future<void> create(String value) async {
    var box = await _box;
    await box.add(value);
  }

  //read
  Future<List> read() async {
    var box = await _box;
    return box.values.toList();
  }

  //update
  Future<void> update(int index, String value) async {
    var box = await _box;
    await box.putAt(index, value);
  }

  //delete
  Future<void> delete(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> clearbox() async {
    var box = await _box;
    await box.clear();
  }
}
