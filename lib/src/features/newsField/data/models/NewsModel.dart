class NewsArticle {
  final int id;
  final String title;
  final String description;
  final String newsPicture;
  final DateTime date;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.newsPicture,
    required this.date,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      newsPicture: json['newsPicture'],
      date: DateTime.parse(json['date']),
    );
  }
}