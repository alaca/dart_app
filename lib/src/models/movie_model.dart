class MovieModel {

  final int id;
  final String poster;
  final String title;
  final double popularity;
  final double rating;

  MovieModel(this.id, this.poster, this.title, this.popularity, this.rating);

  MovieModel.fromJson(Map<String, dynamic> json )
    : id = json['id'],
      poster = json['poster_path'] ?? '',
      title = json['title'],
      popularity = json['popularity'] ?? 0.0,
      rating = json['vote_average'].toDouble() ?? 0.0;

}