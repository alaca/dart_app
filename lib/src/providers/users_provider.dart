
//import 'package:flutter/widgets.dart';
//import 'package:provider/provider.dart';
import 'dart:async';

class UserProvider {


  getPopular() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  final StreamController<int> _users = StreamController();
  Stream<int> stream;

  UserProvider() {
    stream = _users.stream.asBroadcastStream();
  }


  dispose() {
    _users.close();
  }

}