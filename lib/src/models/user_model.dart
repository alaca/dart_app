class UserModel {

  final int id;
  final String image;
  final String name;

  UserModel(this.id, this.image, this.name);

  UserModel.fromJson(Map<String, dynamic> json )
    : id = json['id'],
      image = json['profile_path'],
      name = json['name'];

}