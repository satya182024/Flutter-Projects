import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createdaAtTime,
    required this.createdaAtDate,
    required this.isCompleted,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subTitle;
  @HiveField(3)
  DateTime createdaAtTime;
  @HiveField(4)
  DateTime createdaAtDate;
  @HiveField(5)
  bool isCompleted;

  factory Task.create(
          {required String? title,
          required String? subTitle,
          DateTime? createdAtTime,
          DateTime? createdAtDate}) =>
      Task(
          id: const Uuid().v1(),
          title: title ?? " ",
          subTitle: subTitle ?? " ",
          createdaAtTime: createdAtTime ?? DateTime.now(),
          createdaAtDate: createdAtDate ?? DateTime.now(),
          isCompleted: false);
}
