import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:my_flutter/app/pages/users/users_presenter.dart';
import 'package:my_flutter/data/misc/api_service.dart';
import 'package:my_flutter/data/persistences/mappers/user_mapper.dart';
import 'package:my_flutter/data/persistences/repositories/api/user_api_repository.dart';
import 'package:my_flutter/domain/entities/user.dart';
import 'package:my_flutter/usecases/user/get_users.dart';

class AppComponent {

  static void init() {
    Injector injector = getInjector();
    injector.registerDependency<UserApiMapper>((_) => UserApiMapper());
    injector.registerDependency<Dio>((_) {
      var dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
      return dio;
    });
    injector.registerDependency<ApiService>( (Injector injector) {
      return ApiService(injector.getDependency<Dio>());
    });

    injector.registerSingleton<UserApiRepository>( (Injector injector) {
      return UserApiRepository(
        injector.getDependency<ApiService>(),
        injector.getDependency<UserApiMapper>()
      );
    });

    injector.registerSingleton<StreamController<List<User>>>( (_) {
      StreamController<List<User>> controller = StreamController();
      return controller;
    });
    
    injector.registerSingleton<GetUsers>( (Injector injector) {
      return GetUsers(
        injector.getDependency<UserApiRepository>(),
        injector.getDependency<StreamController<List<User>>>()
      );
    });

    injector.registerSingleton<UsersPresenter>( (Injector injector) {
      return UsersPresenter(injector.getDependency<GetUsers>());
    });
  }

  static Injector getInjector() {
    return Injector.appInstance;
  }

  static parseAndDecode(String response) {
    return jsonDecode(response);
  }
  
  static parseJson(String text) {
    return compute(parseAndDecode, text);
  }
}