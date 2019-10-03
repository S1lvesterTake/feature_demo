import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:my_flutter/app/pages/users/users_presenter.dart';
import 'package:my_flutter/domain/entities/user.dart';

class UsersController extends Controller {
  UsersPresenter _presenter;

  List<User> _users;

  List<User> get users => _users;
  
  UsersController(this._presenter) : super() {
    _users = List<User>();
    loadOnStart();
    load();
  }

  void load() {
    _presenter.onLoadUsers();
  }
  
  @override
  void initListeners() {
    _presenter.getUsersOnNext = (List<User> users) {
      _users = users;
    };

    _presenter.getUsersOnComplete = () {
      // do log here
    };

    _presenter.getUsersOnError = (e) {
      // do log here
    };
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}