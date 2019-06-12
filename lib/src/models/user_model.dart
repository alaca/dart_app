class UserModel {

  final int id;
  final String image;
  final String name;
  final String birthday;
  final String biography;
  final String pob;
  final String homepage;
  final List movies;
  final double popularity;

  UserModel(this.id, this.image, this.name, this.popularity, this.biography, this.birthday, this.pob, this.homepage, this.movies);

  UserModel.fromJson(Map<String, dynamic> json )
    : id = json['id'],
      image = json['profile_path'] ?? '',
      name = json['name'],
      biography = json['biography'],
      birthday = json['birthday'] ?? '',
      pob = json['place_of_birth'] ?? '',
      homepage = json['homepage'] ?? '',
      movies = json['movies'] ?? [],
      popularity = json['popularity'] ?? 0.0;

}