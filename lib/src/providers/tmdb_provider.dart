
import 'dart:async';
import 'package:flutter/widgets.dart';
import '../resources/repository.dart';
import '../models/user_model.dart';
import '../models/movie_model.dart';


class TmdbProvider with ChangeNotifier {

  final _repository = Repository();

  List<UserModel> _users = [];
  List<MovieModel> _movies = [];

  getUsers() async {

    // Initial fetch
    if ( _users.isEmpty )
      _users.addAll(await _repository.getPopular(1));

    return _users;

  }

  getMovies() async {

    // Initial fetch
    if ( _movies.isEmpty )
      _movies.addAll(await _repository.getMovies(1));

    return _movies;

  }

  fetchUsers(int page ) async {

    print(page);

    _users.addAll(await _repository.getPopular(page));

    notifyListeners();

  }

}