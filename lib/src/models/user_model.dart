class UserModel {

  final int id;
  final String image;
  final String name;
  final double popularity;

  UserModel(this.id, this.image, this.name, this.popularity);

  UserModel.fromJson(Map<String, dynamic> json )
    : id = json['id'],
      image = json['profile_path'] ?? null,
      name = json['name'],
      popularity = json['popularity'];

}