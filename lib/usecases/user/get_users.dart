import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:my_flutter/domain/entities/user.dart';
import 'package:my_flutter/domain/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetUsers extends UseCase<List<User>, void> {
  UserRepository _repository;
  StreamController<List<User>> _controller;

  GetUsers(this._repository, this._controller);

  @override
  Future<Observable<List<User>>> buildUseCaseObservable(void ignore) async {
    try {
      List<User> users = await _repository.getAll();
      _controller.add(users);
      logger.finest('GetUsers successfully executed');
      _controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetUsers unsuccessfully executed');
      _controller.addError(e);
    }
    return Observable(_controller.stream);
  }
}