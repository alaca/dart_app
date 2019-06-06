
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/user_model.dart';


class UsersProvider {

  final _repository = Repository();
  final _users = PublishSubject<List<UserModel>>();


  Observable<List<UserModel>> get users => _users.stream;

  getPopular( int page ) async {
    final users = await _repository.getPopular(page);
    _users.sink.add(users);
  }


  dispose() {
    _users.close();
  }

}