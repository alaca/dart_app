import 'dart:async';
import 'tmdb_api_provider.dart';
import '../models/user_model.dart';



class Repository {

  Future<List<UserModel>> getPopular( int page) {
    return TmdbApiProvider().getPopular(page: page);
  }

  Future<UserModel> getUser(int id) async {
    return TmdbApiProvider().getUser(id);
  }

}
