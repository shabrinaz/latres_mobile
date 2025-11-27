import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1) 
class UserModel extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  UserModel({required this.username, required this.password});
}