import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/models/task.dart';

//All the [CRUD] operations method for Hive
class HiveDataStore {
  static const boxName = 'taskBox';

  final Box<Task> box = Hive.box<Task>(boxName);

  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
  }

  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  ///Update
  Future<void> updateTask({required Task task}) async {
    await task.save();
  }

  ///Delete
  Future<void> deleteTask({required Task task}) async {
    await task.delete();
  }

  //Listen to box changes
  /// update the ui according to box changes
  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}
