class GetReadingData {
  GetReadingData({
      String? title, 
      List<Sections>? sections,}){
    _title = title;
    _sections = sections;
}

  GetReadingData.fromJson(dynamic json) {
    _title = json['title'];
    if (json['sections'] != null) {
      _sections = [];
      json['sections'].forEach((v) {
        _sections?.add(Sections.fromJson(v));
      });
    }
  }
  String? _title;
  List<Sections>? _sections;

  String? get title => _title;
  List<Sections>? get sections => _sections;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    if (_sections != null) {
      map['sections'] = _sections?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Sections {
  Sections({
      String? sectionTitle, 
      List<Questions>? questions,}){
    _sectionTitle = sectionTitle;
    _questions = questions;
}

  Sections.fromJson(dynamic json) {
    _sectionTitle = json['section_title'];
    if (json['questions'] != null) {
      _questions = [];
      json['questions'].forEach((v) {
        _questions?.add(Questions.fromJson(v));
      });
    }
  }
  String? _sectionTitle;
  List<Questions>? _questions;

  String? get sectionTitle => _sectionTitle;
  List<Questions>? get questions => _questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['section_title'] = _sectionTitle;
    if (_questions != null) {
      map['questions'] = _questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Questions {
  Questions({
      String? sentence, 
      List<String>? options, 
      String? answer,}){
    _sentence = sentence;
    _options = options;
    _answer = answer;
}

  Questions.fromJson(dynamic json) {
    _sentence = json['sentence'];
    _options = json['options'] != null ? json['options'].cast<String>() : [];
    _answer = json['answer'];
  }
  String? _sentence;
  List<String>? _options;
  String? _answer;

  String? get sentence => _sentence;
  List<String>? get options => _options;
  String? get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sentence'] = _sentence;
    map['options'] = _options;
    map['answer'] = _answer;
    return map;
  }

}