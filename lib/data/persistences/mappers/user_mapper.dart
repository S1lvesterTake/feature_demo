import 'package:my_flutter/domain/entities/user.dart';

class UserApiMapper {
  List<User> convertApiUserList(Map<String, dynamic> response) {
    List<User> users = [];
    for (dynamic data in response["data"]) {
      users.add(new User(
        data["id"], 
        data["name"], 
        data["phone"], 
        data["email"], 
        data["address"]["street"] + " - " + data["address"]["city"]
      ));
    }

    return users;
  }
}