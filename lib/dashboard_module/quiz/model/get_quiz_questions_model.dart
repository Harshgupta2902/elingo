class GetQuizQuestionsModel {
  GetQuizQuestionsModel({
      List<Questions>? questions,}){
    _questions = questions;
}

  GetQuizQuestionsModel.fromJson(dynamic json) {
    if (json['questions'] != null) {
      _questions = [];
      json['questions'].forEach((v) {
        _questions?.add(Questions.fromJson(v));
      });
    }
  }
  List<Questions>? _questions;

  List<Questions>? get questions => _questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_questions != null) {
      map['questions'] = _questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Questions {
  Questions({
      String? question, 
      List<String>? options, 
      String? correctAnswer,}){
    _question = question;
    _options = options;
    _correctAnswer = correctAnswer;
}

  Questions.fromJson(dynamic json) {
    _question = json['question'];
    _options = json['options'] != null ? json['options'].cast<String>() : [];
    _correctAnswer = json['correctAnswer'];
  }
  String? _question;
  List<String>? _options;
  String? _correctAnswer;

  String? get question => _question;
  List<String>? get options => _options;
  String? get correctAnswer => _correctAnswer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = _question;
    map['options'] = _options;
    map['correctAnswer'] = _correctAnswer;
    return map;
  }

}