import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel extends HiveObject {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? text;
  @HiveField(2)
  String status = "new";
  @HiveField(3)
  final DateTime reciveTime;

  NotificationModel(
      {required this.title, required this.text, required this.reciveTime});
}
