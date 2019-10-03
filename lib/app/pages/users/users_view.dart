import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/app/misc/app_component.dart';
import 'package:my_flutter/app/pages/users/users_controller.dart';
import 'package:my_flutter/app/pages/users/users_presenter.dart';

class UsersPage extends View {
  UsersPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UsersPageState createState() => _UsersPageState(UsersController(
      AppComponent.getInjector().getDependency<UsersPresenter>()
    ));
}

class _UsersPageState extends ViewState<UsersPage, UsersController> {

  _UsersPageState(UsersController controller) : super(controller);

  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User List'),
          leading: Icon(Icons.access_time),
        ),
        body: getUsers()
      ),
    );
  }

  ListView getUsers() {
    List<Container> items = controller.users.map((user) => Container(
      child: Center(child: Text(user.email))
    )).toList();

    return ListView(
      children: items
    );
    
  }
}