
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/user_model.dart';


class UsersProvider with ChangeNotifier {

  final _repository = Repository();
  final _users = PublishSubject<List<UserModel>>();

  final _usersOutput = BehaviorSubject<Map<int, Future<UserModel>>>();
  final _usersFetcher = PublishSubject<int>();

  UsersProvider() {
    _usersFetcher.stream.transform(_usersTransformer()).pipe(_usersOutput);
  }

  Observable<List<UserModel>> get popular => _users.stream;
  Observable<Map<int, Future<UserModel>>> get users => _usersOutput.stream;

  getPopular( int page ) async {
    final users = await _repository.getPopular(page);
    _users.sink.add(users);
  }

  Function(int) get fetchItem => _usersFetcher.sink.add; 

  _usersTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<UserModel>> cache, int id, _) {
          cache[id] = _repository.getUser(id);
          return cache;
      },
      <int, Future<UserModel>>{}
    );
  }


  dispose() {
    _users.close();
    _usersOutput.close();
    _usersFetcher.close();
  }

}