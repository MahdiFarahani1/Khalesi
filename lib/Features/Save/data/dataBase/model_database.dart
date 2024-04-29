import 'package:hive/hive.dart';
part 'model_database.g.dart';

@HiveType(typeId: 0)
class ModelDataBase extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String path;

  @HiveField(2)
  String time;
  @HiveField(3)
  int id;
  @HiveField(4)
  String categoryTitle;
  ModelDataBase(
      {required this.id,
      required this.path,
      required this.time,
      required this.title,
      required this.categoryTitle});
}
