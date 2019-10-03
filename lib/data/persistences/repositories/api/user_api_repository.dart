import 'package:logging/logging.dart';
import 'package:my_flutter/data/misc/api_service.dart';
import 'package:my_flutter/data/misc/endpoints.dart';
import 'package:my_flutter/data/persistences/mappers/user_mapper.dart';
import 'package:my_flutter/domain/entities/user.dart';
import 'package:my_flutter/domain/repositories/user_repository.dart';
import 'dart:developer' as developer;

class UserApiRepository extends UserRepository {
  Logger _logger;
  UserApiMapper _mapper;
  ApiService _service;

  UserApiRepository(ApiService service, UserApiMapper mapper) {
    _logger = Logger("UserApiRepository");
    _mapper = mapper;
    _service = service;
  }

  Future<List<User>> getAll() async {
    dynamic resp;
    try {
      resp = await _service.invokeHttp(Endpoints.usersRoute, RequestType.get);
      _logger.finest('Users are successfully retrieved');
    } catch (error) {
      _logger.warning('Could not retrieve users.', error);
      rethrow;
    }

    _logger.finest(resp);
    
    return _mapper.convertApiUserList(resp);
  }
}