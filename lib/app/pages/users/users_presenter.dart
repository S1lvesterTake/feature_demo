import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:my_flutter/domain/entities/user.dart';
import 'package:my_flutter/usecases/user/get_users.dart';

class UsersPresenter extends Presenter {
  GetUsers _usecase;

  Function getUsersOnNext;
  Function getUsersOnComplete;
  Function getUsersOnError;

  UsersPresenter(GetUsers usecase) {
    _usecase = usecase;
  }

  void onLoadUsers() {
    _usecase.execute(_GetUsersObserver(this));
  }

  void dispose() {
    _usecase.dispose();
  }
}

class _GetUsersObserver implements Observer<List<User>> {
  UsersPresenter _presenter;
  _GetUsersObserver(this._presenter);
  
  void onNext(List<User> users) {
    _presenter.getUsersOnNext(users);
  }

  void onComplete() {
    // not implemented yet
    _presenter.getUsersOnComplete();
  }

  void onError(e) {
    _presenter.getUsersOnComplete(e);
  }
}