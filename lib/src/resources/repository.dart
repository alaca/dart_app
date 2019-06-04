import 'dart:async';
import 'tmdb_api_provider.dart';
import '../models/user_model.dart';

TmdbApiProvider api;

class Repository {

  Future<List<UserModel>> getPopular() {
    return api.getPopular();
  }

  Future<UserModel> getUser(int id) async {
    return api.getUser(id);
  }

}
