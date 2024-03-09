class FlashCardDataModel {
  FlashCardDataModel({
    num? status,
    Postdata? postdata,
    String? response,
    List<Words>? words,}){
    _status = status;
    _postdata = postdata;
    _response = response;
    _words = words;
  }

  FlashCardDataModel.fromJson(dynamic json) {
    _status = json['status'];
    _postdata = json['postdata'] != null ? Postdata.fromJson(json['postdata']) : null;
    _response = json['response'];
    if (json['words'] != null) {
      _words = [];
      json['words'].forEach((v) {
        _words?.add(Words.fromJson(v));
      });
    }
  }
  num? _status;
  Postdata? _postdata;
  String? _response;
  List<Words>? _words;

  num? get status => _status;
  Postdata? get postdata => _postdata;
  String? get response => _response;
  List<Words>? get words => _words;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_postdata != null) {
      map['postdata'] = _postdata?.toJson();
    }
    map['response'] = _response;
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
    String? meaning,
    dynamic synonyms,
    dynamic antonyms,
    dynamic exampleSentence,
    dynamic audio,}){
    _id = id;
    _word = word;
    _meaning = meaning;
    _synonyms = synonyms;
    _antonyms = antonyms;
    _exampleSentence = exampleSentence;
    _audio = audio;
  }

  Words.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _meaning = json['meaning'];
    _synonyms = json['synonyms'];
    _antonyms = json['antonyms'];
    _exampleSentence = json['example_sentence'];
    _audio = json['audio'];
  }
  num? _id;
  String? _word;
  String? _meaning;
  dynamic _synonyms;
  dynamic _antonyms;
  dynamic _exampleSentence;
  dynamic _audio;

  num? get id => _id;
  String? get word => _word;
  String? get meaning => _meaning;
  dynamic get synonyms => _synonyms;
  dynamic get antonyms => _antonyms;
  dynamic get exampleSentence => _exampleSentence;
  dynamic get audio => _audio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['meaning'] = _meaning;
    map['synonyms'] = _synonyms;
    map['antonyms'] = _antonyms;
    map['example_sentence'] = _exampleSentence;
    map['audio'] = _audio;
    return map;
  }

}

class Postdata {
  Postdata({
    String? categoryName,}){
    _categoryName = categoryName;
  }

  Postdata.fromJson(dynamic json) {
    _categoryName = json['category_name'];
  }
  String? _categoryName;

  String? get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_name'] = _categoryName;
    return map;
  }

}
class GetFlashCardListData {
  GetFlashCardListData({
    num? status,
    String? response,
    List<CategoryNameList>? categoryNameList,}){
    _status = status;
    _response = response;
    _categoryNameList = categoryNameList;
  }

  GetFlashCardListData.fromJson(dynamic json) {
    _status = json['status'];
    _response = json['response'];
    if (json['CategoryNameList'] != null) {
      _categoryNameList = [];
      json['CategoryNameList'].forEach((v) {
        _categoryNameList?.add(CategoryNameList.fromJson(v));
      });
    }
  }
  num? _status;
  String? _response;
  List<CategoryNameList>? _categoryNameList;

  num? get status => _status;
  String? get response => _response;
  List<CategoryNameList>? get categoryNameList => _categoryNameList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['response'] = _response;
    if (_categoryNameList != null) {
      map['CategoryNameList'] = _categoryNameList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CategoryNameList {
  CategoryNameList({
    String? categoryName,
    String? title,
    String? subTitle,}){
    _categoryName = categoryName;
    _title = title;
    _subTitle = subTitle;
  }

  CategoryNameList.fromJson(dynamic json) {
    _categoryName = json['categoryName'];
    _title = json['title'];
    _subTitle = json['sub_title'];
  }
  String? _categoryName;
  String? _title;
  String? _subTitle;

  String? get categoryName => _categoryName;
  String? get title => _title;
  String? get subTitle => _subTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryName'] = _categoryName;
    map['title'] = _title;
    map['sub_title'] = _subTitle;
    return map;
  }

}