class As {
  As({
      this.status, 
      this.postdata, 
      this.response, 
      this.words,});

  As.fromJson(dynamic json) {
    status = json['status'];
    postdata = json['postdata'];
    response = json['response'];
    if (json['words'] != null) {
      words = [];
      json['words'].forEach((v) {
        words?.add(Words.fromJson(v));
      });
    }
  }
  num? status;
  String? postdata;
  String? response;
  List<Words>? words;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['postdata'] = postdata;
    map['response'] = response;
    if (words != null) {
      map['words'] = words?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Words {
  Words({
      this.id, 
      this.title, 
      this.meaning, 
      this.synonyms, 
      this.antonyms, 
      this.exampleSentence, 
      this.audio,});

  Words.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    meaning = json['meaning'];
    synonyms = json['synonyms'] != null ? json['synonyms'].cast<String>() : [];
    antonyms = json['antonyms'] != null ? json['antonyms'].cast<String>() : [];
    exampleSentence = json['example_sentence'];
    audio = json['audio'];
  }
  num? id;
  String? title;
  String? meaning;
  List<String>? synonyms;
  List<String>? antonyms;
  String? exampleSentence;
  String? audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['meaning'] = meaning;
    map['synonyms'] = synonyms;
    map['antonyms'] = antonyms;
    map['example_sentence'] = exampleSentence;
    map['audio'] = audio;
    return map;
  }

}