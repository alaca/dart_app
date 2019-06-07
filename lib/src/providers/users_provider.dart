
import 'dart:async';
import 'package:flutter/widgets.dart';
import '../resources/repository.dart';
import '../models/user_model.dart';


class UsersProvider with ChangeNotifier {

  final _repository = Repository();

  List<UserModel> _users = [];

  getUsers() async {

    // Initial fetch
    if ( _users.isEmpty )
      return await _repository.getPopular(1);

    return _users;

  }

  fetchUsers(int page ) async {

    _users.addAll(await _repository.getPopular(page));

    notifyListeners();

  }

}