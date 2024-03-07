class FlashCardDataModel {
  FlashCardDataModel({
    List<Words>? words,
  }) {
    _words = words;
  }

  FlashCardDataModel.fromJson(dynamic json) {
    if (json['words'] != null) {
      _words = [];
      json['words'].forEach((v) {
        _words?.add(Words.fromJson(v));
      });
    }
  }

  List<Words>? _words;

  List<Words>? get words => _words;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_words != null) {
      map['words'] = _words?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Words {
  Words({
    num? id,
    String? word,
    List<String>? synonyms,
    List<String>? antonyms,
    String? example,
  }) {
    _id = id;
    _word = word;
    _synonyms = synonyms;
    _antonyms = antonyms;
    _example = example;
  }

  Words.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _synonyms = json['synonyms'] != null ? json['synonyms'].cast<String>() : [];
    _antonyms = json['antonyms'] != null ? json['antonyms'].cast<String>() : [];
    _example = json['example'];
  }

  num? _id;
  String? _word;
  List<String>? _synonyms;
  List<String>? _antonyms;
  String? _example;

  num? get id => _id;

  String? get word => _word;

  List<String>? get synonyms => _synonyms;

  List<String>? get antonyms => _antonyms;

  String? get example => _example;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['synonyms'] = _synonyms;
    map['antonyms'] = _antonyms;
    map['example'] = _example;
    return map;
  }
}
