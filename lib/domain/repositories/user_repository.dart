import 'package:my_flutter/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAll();
}