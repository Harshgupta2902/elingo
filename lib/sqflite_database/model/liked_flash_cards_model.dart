class LikedFlashCardsModel {
  final int? id;
  final String title;
  final String description;
  final String antonyms;
  final String synonyms;

  const LikedFlashCardsModel({
    required this.title,
    required this.description,
    this.id,
    required this.antonyms,
    required this.synonyms,
  });

  factory LikedFlashCardsModel.fromJson(Map<String, dynamic> json) => LikedFlashCardsModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        antonyms: json['antonyms'],
        synonyms: json['synonyms'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'antonyms': antonyms,
        'synonyms': synonyms,
      };
}
