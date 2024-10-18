import 'package:flutter/material.dart';

class DictionaryDataModel {
  DictionaryDataModel({
    String? word,
    String? phonetic,
    List<Phonetics>? phonetics,
    List<Meanings>? meanings,
    License? license,
    List<String>? sourceUrls,
  }) {
    _word = word;
    _phonetic = phonetic;
    _phonetics = phonetics;
    _meanings = meanings;
    _license = license;
    _sourceUrls = sourceUrls;
  }

  DictionaryDataModel.fromJson(dynamic json) {
    try {
      _word = json['word'];
      _phonetic = json['phonetic'];
      if (json['phonetics'] != null) {
        _phonetics = [];
        json['phonetics'].forEach((v) {
          _phonetics?.add(Phonetics.fromJson(v));
        });
      }
      if (json['meanings'] != null) {
        _meanings = [];
        json['meanings'].forEach((v) {
          _meanings?.add(Meanings.fromJson(v));
        });
      }
      _license = json['license'] != null ? License.fromJson(json['license']) : null;
      _sourceUrls = json['sourceUrls'] != null ? json['sourceUrls'].cast<String>() : [];
    } catch (e) {
      debugPrint("Error occurred during JSON parsing: $e");
    }
  }

  String? _word;
  String? _phonetic;
  List<Phonetics>? _phonetics;
  List<Meanings>? _meanings;
  License? _license;
  List<String>? _sourceUrls;

  String? get word => _word;

  String? get phonetic => _phonetic;

  List<Phonetics>? get phonetics => _phonetics;

  List<Meanings>? get meanings => _meanings;

  License? get license => _license;

  List<String>? get sourceUrls => _sourceUrls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['word'] = _word;
    map['phonetic'] = _phonetic;
    if (_phonetics != null) {
      map['phonetics'] = _phonetics?.map((v) => v.toJson()).toList();
    }
    if (_meanings != null) {
      map['meanings'] = _meanings?.map((v) => v.toJson()).toList();
    }
    if (_license != null) {
      map['license'] = _license?.toJson();
    }
    map['sourceUrls'] = _sourceUrls;
    return map;
  }
}

class License {
  License({
    String? name,
    String? url,
  }) {
    _name = name;
    _url = url;
  }

  License.fromJson(dynamic json) {
    try {
      _name = json['name'];
      _url = json['url'];
    } catch (e) {
      debugPrint("Error occurred during License JSON parsing: $e");
    }
  }

  String? _name;
  String? _url;

  String? get name => _name;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['url'] = _url;
    return map;
  }
}

class Meanings {
  Meanings({
    String? partOfSpeech,
    List<Definitions>? definitions,
    List<dynamic>? synonyms,
    List<dynamic>? antonyms,
  }) {
    _partOfSpeech = partOfSpeech;
    _definitions = definitions;
    _synonyms = synonyms;
    _antonyms = antonyms;
  }

  Meanings.fromJson(dynamic json) {
    try {
      _partOfSpeech = json['partOfSpeech'];
      if (json['definitions'] != null) {
        _definitions = [];
        json['definitions'].forEach((v) {
          _definitions?.add(Definitions.fromJson(v));
        });
      }
      if (json['synonyms'] != null) {
        _synonyms = [];
      }
      if (json['antonyms'] != null) {
        _antonyms = [];
      }
    } catch (e) {
      debugPrint("Error occurred during Meanings JSON parsing: $e");
    }
  }

  String? _partOfSpeech;
  List<Definitions>? _definitions;
  List<dynamic>? _synonyms;
  List<dynamic>? _antonyms;

  String? get partOfSpeech => _partOfSpeech;

  List<Definitions>? get definitions => _definitions;

  List<dynamic>? get synonyms => _synonyms;

  List<dynamic>? get antonyms => _antonyms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['partOfSpeech'] = _partOfSpeech;
    if (_definitions != null) {
      map['definitions'] = _definitions?.map((v) => v.toJson()).toList();
    }
    if (_synonyms != null) {
      map['synonyms'] = _synonyms?.map((v) => v.toJson()).toList();
    }
    if (_antonyms != null) {
      map['antonyms'] = _antonyms?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Definitions {
  Definitions({
    String? definition,
    List<dynamic>? synonyms,
    List<dynamic>? antonyms,
    String? example,
  }) {
    _definition = definition;
    _synonyms = synonyms;
    _antonyms = antonyms;
    _example = example;
  }

  Definitions.fromJson(dynamic json) {
    try {
      _definition = json['definition'];
      if (json['synonyms'] != null) {
        _synonyms = [];
      }
      if (json['antonyms'] != null) {
        _antonyms = [];
      }
      _example = json['example'];
    } catch (e) {
      debugPrint("Error occurred during Definitions JSON parsing: $e");
    }
  }

  String? _definition;
  List<dynamic>? _synonyms;
  List<dynamic>? _antonyms;
  String? _example;

  String? get definition => _definition;

  List<dynamic>? get synonyms => _synonyms;

  List<dynamic>? get antonyms => _antonyms;

  String? get example => _example;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['definition'] = _definition;

    if (_synonyms != null) {
      map['synonyms'] = _synonyms?.map((v) => v.toJson()).toList();
    }
    if (_antonyms != null) {
      map['antonyms'] = _antonyms?.map((v) => v.toJson()).toList();
    }
    map['example'] = _example;
    return map;
  }
}

class Phonetics {
  Phonetics({
    String? text,
    String? audio,
  }) {
    _text = text;
    _audio = audio;
  }

  Phonetics.fromJson(dynamic json) {
    try {
      _text = json['text'];
      _audio = json['audio'];
    } catch (e) {
      debugPrint("Error occurred during Phonetics JSON parsing: $e");
    }
  }

  String? _text;
  String? _audio;

  String? get text => _text;

  String? get audio => _audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['audio'] = _audio;
    return map;
  }
}
